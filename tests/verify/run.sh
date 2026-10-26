#!/usr/bin/env bash
# run.sh - fixture tests for scripts/verify.sh (offline, self-contained).
# Usage: bash tests/verify/run.sh
# Env:   VERIFY_SH  path to the verify script under test (default: <repo>/scripts/verify.sh)
# Every fixture is generated inside a mktemp git repo; nothing in the real repo is touched.
set -u
unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE GIT_COMMON_DIR GIT_OBJECT_DIRECTORY GIT_ALTERNATE_OBJECT_DIRECTORIES GIT_NAMESPACE GIT_PREFIX

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/../.." && pwd)"
VERIFY_SH="${VERIFY_SH:-$REPO/scripts/verify.sh}"

TMPS=()
cleanup() { local d; for d in "${TMPS[@]:-}"; do [ -n "$d" ] && rm -rf "$d"; done; }
trap cleanup EXIT

PASS=0
FAIL=0
N=0
OUT=""
RC=0
ERRS=""

# mkrepo: create temp git repo, set REPO_T
mkrepo() {
  REPO_T="$(mktemp -d)"
  TMPS+=("$REPO_T")
  git init -q "$REPO_T"
  git -C "$REPO_T" config user.name "verify-test"
  git -C "$REPO_T" config user.email "verify-test@example.invalid"
}

# put <relpath>: write stdin to file in temp repo
put() { mkdir -p "$(dirname "$REPO_T/$1")"; cat > "$REPO_T/$1"; }

sha() { sha256sum "$REPO_T/$1" | cut -d' ' -f1; }

# manifest <json-body-of-files> [seedFiles-json]
manifest() {
  printf '{"files": {%s}, "seedFiles": [%s]}\n' "$1" "${2:-}" > "$REPO_T/orchestration-kit.manifest.json"
}

# run_v [args...]: run verify against REPO_T
run_v() {
  OUT="$(bash "$VERIFY_SH" --root "$REPO_T" "$@" 2>&1)"
  RC=$?
}

# assertions accumulate into ERRS
expect_rc() { [ "$RC" -eq "$1" ] || ERRS+=" exit=$RC (want $1);"; }
expect_line() { printf '%s\n' "$OUT" | grep -Fxq -- "$1" || ERRS+=" missing line [$1];"; }
expect_no() { ! printf '%s\n' "$OUT" | grep -Fq -- "$1" || ERRS+=" unexpected [$1];"; }

# finish <case name>
finish() {
  N=$((N + 1))
  if [ -z "$ERRS" ]; then
    echo "ok $N - $1"; PASS=$((PASS + 1))
  else
    echo "not ok $N - $1 --$ERRS"
    printf '%s\n' "$OUT" | sed 's/^/#   /'
    FAIL=$((FAIL + 1))
  fi
  ERRS=""
}

# 1 clean tree
mkrepo
put ok.sh <<'X'
#!/usr/bin/env bash
echo hello
X
put target.md <<'X'
# Target
X
put doc.md <<'X'
See [target](target.md).
X
manifest "\"target.md\": \"$(sha target.md)\""
run_v
expect_rc 0; expect_line "verify: 3 checks run, 0 failed"; expect_line "PASS syntax"; expect_line "PASS links"; expect_line "PASS kit"
finish "clean tree passes all 3 checks"

# 2 syntax failure
mkrepo
put bad.sh <<'X'
if then fi (
X
run_v --only syntax
expect_rc 1; expect_line "FAIL syntax: bad.sh"; expect_line "verify: 1 checks run, 1 failed"
finish "script failing bash -n is reported"

# 3 broken link
mkrepo
put a.md <<'X'
line one
Go to [gone](missing.md) now.
X
run_v --only links
expect_rc 1; expect_line "FAIL links: a.md:2: missing.md"
finish "broken relative link is reported with file:line:target"

# 4 fenced and inline-code links ignored
mkrepo
put a.md <<'X'
```
[gone](fenced-missing.md)
```
Inline `[gone](inline-missing.md)` code.
X
run_v --only links
expect_rc 0; expect_line "PASS links"; expect_no "FAIL links"
finish "links in fenced blocks and inline code are not reported"

# 5 external and anchor links ignored
mkrepo
put a.md <<'X'
[ext](https://example.invalid/x) and [anchor](#section) and [mail](mailto:a@b.invalid)
X
run_v --only links
expect_rc 0; expect_line "PASS links"; expect_no "FAIL links"
finish "external and anchor links are not reported"

# 6 modified manifest file
mkrepo
put f.md <<'X'
original
X
manifest "\"f.md\": \"$(sha f.md)\""
echo changed >> "$REPO_T/f.md"
run_v --only kit
expect_rc 1; expect_line "FAIL kit: modified f.md"
finish "manifest file modified after hashing is reported"

# 7 unresolved {{TOKEN}}
mkrepo
put f.md <<'X'
name: {{SOME_TOKEN}}
X
manifest "\"f.md\": \"$(sha f.md)\""
run_v --only kit
expect_rc 1; expect_line "FAIL kit: unresolved token in f.md"
finish "manifest file with {{TOKEN}} is reported"

# 8 no manifest
mkrepo
run_v --only kit
expect_rc 0; expect_line "SKIP kit: no orchestration-kit.manifest.json"
finish "missing manifest skips kit check"

# 9 usage errors
mkrepo
run_v --only bogus
expect_rc 2; expect_line "verify.sh: unknown --only value: bogus (expected syntax|links|kit)"
finish "--only bogus is a usage error"

NONGIT="$(mktemp -d)"; TMPS+=("$NONGIT")
OUT="$(bash "$VERIFY_SH" --root "$NONGIT" 2>&1)"; RC=$?
expect_rc 2; expect_line "verify.sh: --root is not a git work tree: $NONGIT"
finish "non-git --root is a usage error"

# 10 deleted manifest file
mkrepo
put f.md <<'X'
x
X
manifest "\"f.md\": \"$(sha f.md)\""
rm "$REPO_T/f.md"
run_v --only kit
expect_rc 1; expect_line "FAIL kit: missing f.md"
finish "manifest file deleted is reported"

# 11 seedFiles modified is allowed
mkrepo
put f.md <<'X'
seed
X
manifest "\"f.md\": \"$(sha f.md)\"" "\"f.md\""
echo "user edit" >> "$REPO_T/f.md"
run_v --only kit
expect_rc 0; expect_no "FAIL kit"; expect_line "PASS kit"
finish "modified seedFiles entry is not reported"

# 12 BOOTSTRAP marker
mkrepo
put f.md <<'X'
<!-- BOOTSTRAP: fill me -->
X
manifest "\"f.md\": \"$(sha f.md)\""
run_v --only kit
expect_rc 1; expect_line "FAIL kit: unresolved token in f.md"
finish "manifest file with BOOTSTRAP marker is reported"

# 13 untracked broken script
mkrepo
put tracked.sh <<'X'
echo ok
X
git -C "$REPO_T" add tracked.sh
git -C "$REPO_T" commit -q -m init
put untracked.sh <<'X'
echo "unterminated
X
run_v --only syntax
expect_rc 1; expect_line "FAIL syntax: untracked.sh"; expect_no "FAIL syntax: tracked.sh"
finish "untracked broken script is reported"

# 14 fixtures dir excluded
mkrepo
put tests/verify/fixtures/bad.sh <<'X'
if then fi (
X
put tests/verify/fixtures/bad.md <<'X'
[gone](nowhere.md)
X
run_v
expect_rc 0; expect_line "verify: 3 checks run, 0 failed"; expect_no "FAIL"
finish "files under tests/verify/fixtures/ are ignored"

# 15 manifest-listed md and .agents md skipped by links
mkrepo
put listed.md <<'X'
[gone](nowhere.md)
X
put .agents/x.md <<'X'
[gone](nowhere.md)
X
manifest "\"listed.md\": \"$(sha listed.md)\""
run_v --only links
expect_rc 0; expect_line "PASS links"; expect_no "FAIL links"
finish "links in manifest-listed and .agents md files are skipped"

# 16 memory sub-check skipped when _kit/memory.sh absent
mkrepo
put f.md <<'X'
x
X
manifest "\"f.md\": \"$(sha f.md)\""
run_v --only kit
expect_rc 0; expect_line "SKIP kit: memory check (no _kit/memory.sh)"; expect_line "PASS kit"
finish "absent _kit/memory.sh yields SKIP for memory sub-check"

echo "# $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
