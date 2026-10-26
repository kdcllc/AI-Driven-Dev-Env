#!/usr/bin/env bash
# verify.sh - single offline verification command (syntax, links, kit).
# Usage: scripts/verify.sh [--root <dir>] [--only <syntax|links|kit>] [-h|--help]
# Exit: 0 all run checks pass (SKIP counts as pass) · 1 a check failed · 2 usage error.
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/verify.sh [--root <dir>] [--only <syntax|links|kit>] [-h|--help]

Checks (run in this order unless --only is given):
  syntax  bash -n on every *.sh file
  links   relative markdown links in *.md files resolve
  kit     orchestration-kit.manifest.json hashes, unresolved tokens, _kit/memory.sh check

Exit codes: 0 pass · 1 a check failed · 2 usage error
USAGE
}

die_usage() { echo "verify.sh: $1" >&2; exit 2; }

ROOT=""
ONLY=""
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --root)
      [ $# -ge 2 ] || die_usage "--root requires a directory"
      ROOT="$2"; shift 2 ;;
    --only)
      [ $# -ge 2 ] || die_usage "--only requires a value (syntax|links|kit)"
      ONLY="$2"; shift 2 ;;
    *) die_usage "unknown argument: $1" ;;
  esac
done

case "$ONLY" in
  ""|syntax|links|kit) ;;
  *) die_usage "unknown --only value: $ONLY (expected syntax|links|kit)" ;;
esac

if [ -z "$ROOT" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null)" \
    || die_usage "cannot determine git top-level from script location"
fi
[ -d "$ROOT" ] || die_usage "--root is not a directory: $ROOT"
if [ "$(git -C "$ROOT" rev-parse --is-inside-work-tree 2>/dev/null || true)" != "true" ]; then
  die_usage "--root is not a git work tree: $ROOT"
fi
ROOT="$(cd "$ROOT" && pwd)"

MANIFEST="$ROOT/orchestration-kit.manifest.json"
EXCL_PREFIX="tests/verify/fixtures/"

# Discover tracked + untracked-not-ignored files, sorted, deduped, existing, minus fixtures.
FILES=()
while IFS= read -r -d '' f; do
  case "$f" in "$EXCL_PREFIX"*) continue ;; esac
  [ -f "$ROOT/$f" ] || continue
  FILES+=("$f")
done < <( { git -C "$ROOT" ls-files -z; git -C "$ROOT" ls-files -z --others --exclude-standard; } \
          | tr '\0' '\n' | LC_ALL=C sort -u | tr '\n' '\0' )

CHECKS_RUN=0
CHECKS_FAILED=0

finish_check() { # name failcount
  CHECKS_RUN=$((CHECKS_RUN + 1))
  if [ "$2" -eq 0 ]; then
    echo "PASS $1"
  else
    CHECKS_FAILED=$((CHECKS_FAILED + 1))
  fi
}

check_syntax() {
  local fails=0 f err
  for f in "${FILES[@]}"; do
    case "$f" in *.sh) ;; *) continue ;; esac
    if ! err="$(bash -n "$ROOT/$f" 2>&1)"; then
      echo "FAIL syntax: $f"
      [ -z "$err" ] || printf '%s\n' "$err"
      fails=$((fails + 1))
    fi
  done
  finish_check syntax "$fails"
}

check_links() {
  local fails=0 out
  local mdlist
  mdlist="$(for f in "${FILES[@]}"; do case "$f" in *.md) printf '%s\n' "$f" ;; esac; done)"
  out="$(printf '%s\n' "$mdlist" | python3 -c '
import json, os, re, sys, urllib.parse
root, manifest = sys.argv[1], sys.argv[2]
skip = set()
if os.path.isfile(manifest):
    try:
        skip = set(json.load(open(manifest, encoding="utf-8")).get("files", {}))
    except Exception:
        pass
pat = re.compile(r"!?\[[^\]]*\]\(\s*(<[^>]*>|[^)\s]+)(?:\s+\"[^\"]*\")?\s*\)")
code = re.compile(r"(`+)(?:(?!\1).)+?\1")
outer = re.compile(r"\[!\[[^\]]*\]\([^)]*\)\]\(\s*(<[^>]*>|[^)\s]+)(?:\s+\"[^\"]*\")?\s*\)")
scheme = re.compile(r"^[A-Za-z][A-Za-z0-9+.-]*:")
sys.stdout.reconfigure(errors="backslashreplace")
for f in os.fsdecode(sys.stdin.buffer.read()).split("\n"):
    if not f or f.startswith(".agents/") or f in skip:
        continue
    infence = False
    try:
        lines = open(os.path.join(root, f), encoding="utf-8", errors="replace").read().split("\n")
    except OSError:
        continue
    for i, line in enumerate(lines, 1):
        if line.lstrip().startswith("```"):
            infence = not infence
            continue
        if infence:
            continue
        line = code.sub("", line)
        for t in pat.findall(line) + outer.findall(line):
            if t.startswith("<") and t.endswith(">"):
                t = t[1:-1]
            if scheme.match(t) or t.startswith("#"):
                continue
            p = re.split(r"[#?]", t, 1)[0]
            if not p:
                continue
            p = urllib.parse.unquote(p)
            if p.startswith("/"):
                tgt = os.path.join(root, p.lstrip("/"))
            else:
                tgt = os.path.join(root, os.path.dirname(f), p)
            if not os.path.exists(os.path.normpath(tgt)):
                print("FAIL links: %s:%d: %s" % (f, i, t))
' "$ROOT" "$MANIFEST")"
  if [ -n "$out" ]; then
    printf '%s\n' "$out"
    fails="$(printf '%s\n' "$out" | wc -l)"
  fi
  finish_check links "$fails"
}

check_kit() {
  if [ ! -f "$MANIFEST" ]; then
    echo "SKIP kit: no orchestration-kit.manifest.json"
    CHECKS_RUN=$((CHECKS_RUN + 1))
    return 0
  fi
  local fails=0 out
  out="$(python3 -c '
import hashlib, json, os, re, sys
root, manifest = sys.argv[1], sys.argv[2]
m = json.load(open(manifest, encoding="utf-8"))
seeds = set(m.get("seedFiles", []))
tok = re.compile(r"\{\{[A-Z][A-Z0-9_]*\}\}")
for path, want in sorted(m.get("files", {}).items()):
    full = os.path.join(root, path)
    if not os.path.isfile(full):
        print("FAIL kit: missing " + path)
        continue
    data = open(full, "rb").read()
    if path not in seeds and hashlib.sha256(data).hexdigest() != want:
        print("FAIL kit: modified " + path)
    text = data.decode("utf-8", errors="replace")
    if tok.search(text) or "<!-- BOOTSTRAP" in text:
        print("FAIL kit: unresolved token in " + path)
' "$ROOT" "$MANIFEST")" || { echo "FAIL kit: manifest unreadable"; out=""; fails=1; }
  if [ -n "$out" ]; then
    printf '%s\n' "$out"
    fails=$((fails + $(printf '%s\n' "$out" | wc -l)))
  fi
  if [ -f "$ROOT/_kit/memory.sh" ]; then
    local mout
    if ! mout="$(bash "$ROOT/_kit/memory.sh" check --root "$ROOT" 2>&1)"; then
      echo "FAIL kit: memory check"
      [ -z "$mout" ] || printf '%s\n' "$mout"
      fails=$((fails + 1))
    fi
  else
    echo "SKIP kit: memory check (no _kit/memory.sh)"
  fi
  finish_check kit "$fails"
}

if [ -z "$ONLY" ] || [ "$ONLY" = syntax ]; then check_syntax; fi
if [ -z "$ONLY" ] || [ "$ONLY" = links ];  then check_links;  fi
if [ -z "$ONLY" ] || [ "$ONLY" = kit ];    then check_kit;    fi

echo "verify: $CHECKS_RUN checks run, $CHECKS_FAILED failed"
[ "$CHECKS_FAILED" -eq 0 ] || exit 1
exit 0
