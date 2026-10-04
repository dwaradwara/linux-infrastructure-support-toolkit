#!/usr/bin/env bash

set -u

VERSION="1.1.0"
TIMESTAMP="$(date -u +%Y%m%d-%H%M%S)"
HOSTNAME_VALUE="$(hostname)"
OUTPUT_DIR="support-bundle-${HOSTNAME_VALUE}-${TIMESTAMP}"
ARCHIVE="${OUTPUT_DIR}.tar.gz"
MANIFEST="${OUTPUT_DIR}/manifest.txt"

mkdir -p "$OUTPUT_DIR"

cat > "$MANIFEST" <<META
Linux Infrastructure Support Bundle
Version: $VERSION
Hostname: $HOSTNAME_VALUE
Generated UTC: $(date -u '+%Y-%m-%d %H:%M:%S')
Collector: allowlisted diagnostics only

Security:
- does not collect private SSH keys
- does not collect /etc/shadow
- does not collect environment-variable dumps
- does not collect API tokens or passwords
META

run_check() {
    local name="$1"
    shift

    local output_file="$OUTPUT_DIR/${name}.txt"
    local rc=0

    {
        echo "===== $name ====="
        echo "Command: $*"
        echo
    } > "$output_file"

    "$@" >> "$output_file" 2>&1 || rc=$?

    {
        echo
        echo "Exit status: $rc"
    } >> "$output_file"

    printf '%-24s exit=%s\n' "$name" "$rc" >> "$MANIFEST"
}

run_check system-info uname -a
run_check os-release cat /etc/os-release
run_check uptime uptime
run_check memory free -m
run_check disk-usage df -h
run_check inode-usage df -i
run_check block-devices lsblk
run_check ip-addresses ip addr
run_check routes ip route
run_check listening-ports ss -lntup
run_check failed-services systemctl --failed
run_check recent-errors journalctl -p err -n 100 --no-pager

if command -v docker >/dev/null 2>&1; then
    run_check docker-version docker --version
    run_check docker-containers docker ps -a
fi

if command -v kubectl >/dev/null 2>&1; then
    run_check kubernetes-pods kubectl get pods -A -o wide
fi

tar -czf "$ARCHIVE" "$OUTPUT_DIR"

sha256sum "$ARCHIVE" > "${ARCHIVE}.sha256"

echo
echo "Support bundle created:"
echo "$ARCHIVE"
echo
echo "Checksum:"
cat "${ARCHIVE}.sha256"
