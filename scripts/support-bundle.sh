#!/usr/bin/env bash

set -u

OUTPUT_DIR="support-bundle-$(hostname)-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$OUTPUT_DIR"

run_check() {
    local name="$1"
    shift

    {
        echo "===== $name ====="
        echo "Command: $*"
        echo
        "$@" 2>&1 || true
        echo
    } > "$OUTPUT_DIR/$name.txt"
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
    run_check docker-info docker info
    run_check docker-containers docker ps -a
fi

if command -v kubectl >/dev/null 2>&1; then
    run_check kubernetes-pods kubectl get pods -A -o wide
fi

tar -czf "${OUTPUT_DIR}.tar.gz" "$OUTPUT_DIR"

echo "Support bundle created:"
echo "${OUTPUT_DIR}.tar.gz"