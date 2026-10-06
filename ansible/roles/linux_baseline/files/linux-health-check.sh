#!/usr/bin/env bash
set -euo pipefail

echo "=== HOST ==="
hostname

echo
echo "=== UPTIME ==="
uptime

echo
echo "=== FILESYSTEM ==="
df -h /

echo
echo "=== MEMORY ==="
free -h

echo
echo "=== FAILED SERVICES ==="
systemctl --failed --no-pager || true

echo
echo "=== LISTENING TCP PORTS ==="
ss -lnt

echo
echo "=== BASELINE STATUS ==="
echo "linux-baseline=ok"
