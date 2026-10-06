# Ansible Linux Baseline Automation

This directory contains an Ansible role that applies and validates a repeatable Linux infrastructure baseline on an Ubuntu VM.

## Environment

- Ubuntu 22.04 LTS
- KVM/libvirt VM: `devops-app-01`
- Ansible control node: WSL
- Ansible Core 2.20.1

## Automation

The `linux_baseline` role:

- installs `curl`, `jq`, `rsync`, `unzip`, and `chrony`
- creates the `ops-support` group
- adds `devops` to `ops-support`
- creates `/opt/linux-support`
- installs `/usr/local/bin/linux-health-check`
- ensures Chrony is enabled and running
- creates `/etc/linux-infrastructure-baseline`

## Idempotency

First execution:

```text
ok=8 changed=6 unreachable=0 failed=0
```

Second execution:

```text
ok=8 changed=0 unreachable=0 failed=0
```

The second run confirms that the role is idempotent.

## Target Validation

- `devops` belongs to `ops-support`
- `/opt/linux-support` is owned by `root:ops-support`
- health-check utility is executable
- Chrony is enabled and active
- no failed systemd services were reported
- baseline marker exists
- health check returns `linux-baseline=ok`

## Evidence

- `evidence/01-first-run.txt`
- `evidence/02-idempotency-run.txt`
- `evidence/03-target-validation.txt`

## Operational Principle

Configuration-management automation should converge systems to the desired state without making unnecessary changes on subsequent runs.
