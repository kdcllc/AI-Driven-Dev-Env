#!/usr/bin/env bash
# dotnet-inventory.sh — read-only report of every .NET install on this Linux box,
# and how dotnetup (shell access mode) would interact with it.
# Usage: ./dotnet-inventory.sh [project-dir]   (project-dir is searched upward for global.json)
set -uo pipefail

PROJECT_DIR="${1:-$PWD}"
WARN=()
warn() { WARN+=("$*"); }
hdr()  { printf '\n=== %s ===\n' "$*"; }

declare -A ROOTS=()   # resolved root dir -> how we found it
add_root() { [[ -n "$1" && -x "$1/dotnet" ]] && ROOTS["$1"]+="${ROOTS[$1]:+, }$2"; }

# 1. dotnet on PATH
hdr "1. dotnet on PATH (in resolution order)"
mapfile -t HITS < <(type -a -p dotnet 2>/dev/null | awk '!seen[$0]++')
if ((${#HITS[@]} == 0)); then
  echo "  (none)"
else
  for h in "${HITS[@]}"; do
    real=$(readlink -f "$h")
    printf '  %s -> %s\n' "$h" "$real"
    add_root "$(dirname "$real")" "PATH"
    if [[ -L "$h" ]]; then
      warn "$h is a symlink (owner $(stat -c '%U' "$h")) to $real; processes not started from your shell (desktop apps, sudo, systemd, global tools) use it. Keep it pointing at the root you manage."
    fi
  done
  echo "  first-hit version: $("${HITS[0]}" --version 2>/dev/null || echo '?')"
  if (( $(printf '%s\n' "${HITS[@]}" | xargs -n1 readlink -f | sort -u | wc -l) > 1 )); then
    warn "More than one distinct dotnet binary on PATH; whichever comes first wins today."
  fi
fi

# 2. Environment
hdr "2. Environment variables"
for v in DOTNET_ROOT DOTNET_ROOT_X64 DOTNET_HOST_PATH DOTNET_INSTALL_DIR DOTNET_CLI_HOME \
         DOTNET_MULTILEVEL_LOOKUP NUGET_PACKAGES MSBuildSDKsPath; do
  printf '  %-26s %s\n' "$v" "${!v:-(unset)}"
done
[[ -n "${DOTNET_ROOT:-}" ]] && { add_root "$DOTNET_ROOT" "DOTNET_ROOT";
  warn "DOTNET_ROOT is already set to $DOTNET_ROOT; dotnetup shell mode will override it in its profile block — check ordering in your shell rc."; }
[[ -n "${MSBuildSDKsPath:-}" ]] && warn "MSBuildSDKsPath is set; it pins MSBuild SDK resolution regardless of which dotnet runs."

# 3. Well-known roots
hdr "3. Well-known install roots"
for r in /usr/share/dotnet /usr/lib/dotnet /usr/lib64/dotnet /opt/dotnet /usr/local/share/dotnet \
         "$HOME/.dotnet" "$HOME/.local/share/dotnet" /home/linuxbrew/.linuxbrew/opt/dotnet/libexec \
         /snap/dotnet-sdk/current; do
  if [[ -x "$r/dotnet" ]]; then echo "  [found] $r"; add_root "$(readlink -f "$r")" "well-known"
  else echo "  [ -- ]  $r"; fi
done

# 4. Package managers
hdr "4. Package-manager owned installs"
if command -v dpkg-query >/dev/null; then
  dpkg-query -W -f='  dpkg: ${Package} ${Version} [${Status}]\n' 2>/dev/null \
    | grep -Ei 'dotnet|aspnetcore|netstandard' | grep 'install ok installed' \
    && warn "apt/dpkg owns .NET packages; apt upgrades will keep changing that root independently of dotnetup."
fi
command -v rpm    >/dev/null && rpm -qa 2>/dev/null | grep -Ei 'dotnet|aspnetcore' | sed 's/^/  rpm: /'
command -v pacman >/dev/null && pacman -Q 2>/dev/null | grep -Ei 'dotnet|aspnet' | sed 's/^/  pacman: /'
command -v brew   >/dev/null && brew list --versions 2>/dev/null | grep -Ei 'dotnet' | sed 's/^/  brew: /'
if command -v snap >/dev/null && snap list 2>/dev/null | grep -qi dotnet; then
  snap list 2>/dev/null | grep -i dotnet | sed 's/^/  snap: /'
  warn "A snap .NET is installed; snap confinement and its own PATH shim can shadow dotnetup."
fi

# 5. Per-root contents
hdr "5. Contents of each discovered root"
for r in "${!ROOTS[@]}"; do
  echo "  --- $r  (via ${ROOTS[$r]})"
  echo "      owner: $(stat -c '%U' "$r")   writable by you: $([[ -w $r ]] && echo yes || echo no)"
  echo "      SDKs:";     "$r/dotnet" --list-sdks     2>/dev/null | sed 's/^/        /'
  echo "      Runtimes:"; "$r/dotnet" --list-runtimes 2>/dev/null | sed 's/^/        /'
  wl=$(DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1 "$r/dotnet" workload list 2>/dev/null \
       | awk '/^-+$/{f=1;next} f && NF && !/^Use /{print}')
  if [[ -n "$wl" ]]; then
    echo "      Workloads:"; echo "$wl" | sed 's/^/        /'
    warn "Root $r has workloads installed; dotnetup does not migrate workloads — reinstall them under the dotnetup root."
  fi
done
((${#ROOTS[@]} > 1)) && warn "${#ROOTS[@]} separate .NET roots exist; each keeps its own SDK/runtime set."

# 6. Shell profiles
hdr "6. Shell profile lines touching dotnet"
for f in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile" "$HOME/.zshrc" "$HOME/.zprofile" \
         /etc/profile /etc/environment /etc/profile.d/*; do
  [[ -r $f ]] || continue
  grep -nEi 'dotnet|DOTNET_' "$f" 2>/dev/null | sed "s|^|  $f:|"
done

# 7. dotnetup
hdr "7. dotnetup"
if command -v dotnetup >/dev/null; then
  echo "  installed: $(command -v dotnetup)"
  dotnetup env show 2>/dev/null | sed 's/^/  /'
  dotnetup list     2>/dev/null | sed 's/^/  /'
else
  echo "  not installed"
fi

# 8. global.json
hdr "8. global.json (searching upward from $PROJECT_DIR)"
d=$(readlink -f "$PROJECT_DIR"); GJ=""
while [[ -n "$d" ]]; do [[ -f "$d/global.json" ]] && { GJ="$d/global.json"; break; }; [[ "$d" == / ]] && break; d=$(dirname "$d"); done
if [[ -n "$GJ" ]]; then
  echo "  $GJ"; sed 's/^/    /' "$GJ"
  PIN=$(grep -oP '"version"\s*:\s*"\K[^"]+' "$GJ" | head -1)
  ROLL=$(grep -oP '"rollForward"\s*:\s*"\K[^"]+' "$GJ" | head -1)
  echo "  pinned: ${PIN:-none}  rollForward: ${ROLL:-default(patch)}"
  if [[ -n "$PIN" ]]; then
    for r in "${!ROOTS[@]}"; do
      "$r/dotnet" --list-sdks 2>/dev/null | grep -q "^$PIN " && echo "  exact pin present in $r"
    done
    warn "If you adopt dotnetup, run: dotnetup sdk install $PIN  (or --migrate-from-system) so the pin resolves from the dotnetup root."
  fi
else
  echo "  none found"
fi

# 9. Assessment
hdr "9. Assessment"
cat <<'EOF'
  On Linux dotnetup uses 'shell' mode: it prepends its own root to PATH and sets DOTNET_ROOT in your
  shell profile. Existing roots are not modified or removed. Processes started from that shell use
  dotnetup's SDKs; anything not started from it (IDE launched from a desktop launcher, systemd, cron)
  keeps using whatever it resolved before.
EOF
if ((${#WARN[@]})); then for w in "${WARN[@]}"; do echo "  [!] $w"; done
else echo "  [ok] Nothing found that would conflict."; fi
