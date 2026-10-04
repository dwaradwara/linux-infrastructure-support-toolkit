# Linux Infrastructure Support & Diagnostic Toolkit

Hands-on Linux L2 infrastructure support portfolio demonstrating structured troubleshooting, evidence collection, root-cause analysis, customer communication, escalation readiness, and knowledge-base documentation.

All incidents were reproduced in isolated lab environments. No production systems or customer data were used.

## Repository Scope

This repository is a general Linux L2 support toolkit focused on cross-layer troubleshooting, structured case handling, diagnostic evidence, RCA, customer communication, and escalation readiness.

The separate `ubuntu-kvm-support-lab` goes deeper into Ubuntu-specific and virtualization-focused support scenarios. This repository is intentionally broader and demonstrates a repeatable support workflow across services, networking, containers, virtualization, resource controls, and filesystems.

## Lab Environment

| Component | Environment |
|---|---|
| Control host | Ubuntu 26.04 LTS on WSL2 |
| Control-host kernel | 6.18.33.2-microsoft-standard-WSL2 |
| Primary workload VM | Ubuntu 22.04.5 LTS |
| VM kernel | 5.15.0-194-generic |
| VM resources | 2 vCPU, 2 GiB RAM |
| Service manager | systemd 249 |
| cgroup mode | cgroup v2 |
| Container runtime | Docker 29.1.3 |
| Virtualization | KVM/QEMU with libvirt |
| libvirt | 12.0.0 |
| QEMU | 10.2.1 |
| CI validation | GitHub Actions running ShellCheck against `scripts/*.sh` |

Primary workload VM: `devops-app-01`

## Support Workflow

Customer report → assess impact/severity → reproduce → collect evidence → isolate failing layer → identify root cause → controlled remediation → validate recovery → customer response → KB/escalation package.

## Incident Portfolio

| Incident | Domain | Root Cause | Key Tools |
|---|---|---|---|
| INC001 | systemd / processes | TCP port conflict prevented service startup | systemctl, journalctl, ss, lsof, curl |
| INC002 | DNS / networking | Missing hostname-resolution entry | getent, curl, ip, resolvectl |
| INC003 | Docker | Published port did not match application port | docker ps, docker port, docker inspect, logs |
| INC004 | KVM / libvirt | qcow2 disk unavailable at configured path | virsh, domain XML, block-device inspection |
| INC005 | cgroups / memory | MemoryMax caused memory-cgroup OOM termination | journalctl, kernel logs, systemctl show, free |
| INC006 | ext4 filesystem | Inode exhaustion while disk blocks remained available | df -h, df -i, findmnt, du --inodes |

## INC001 — systemd Service Start Failure

A systemd-managed application failed to start because another process already occupied its required TCP port.

The conflict was isolated using systemd logs, socket inspection, and process ownership checks. After removing the conflicting process, the service returned to active state and HTTP validation returned 200 OK.

## INC002 — DNS / Name Resolution Failure

A backend service remained healthy and reachable directly by IP while hostname-based communication failed.

The investigation separated application health, socket state, routing, and hostname resolution. The issue was isolated to missing name resolution and restored without unnecessary application changes.

## INC003 — Docker Service Unreachable

The Docker container reported Running, but the published endpoint was unavailable.

Investigation showed that host port 18083 forwarded to container port 9000 while the application actually listened on port 8000.

Correcting the port mapping restored HTTP connectivity.

## INC004 — KVM/libvirt Storage Failure

A defined virtual machine failed to start because its configured qcow2 disk was unavailable.

The investigation used virsh domblklist, domain XML, filesystem inspection, and storage-path validation.

After restoring the expected qcow2 volume, the VM started successfully and returned to running state.

## INC005 — cgroup Memory Limit / OOM

A systemd service repeatedly terminated during a controlled memory workload even though the host still had available RAM.

Kernel evidence confirmed a memory-cgroup OOM event and systemd reported the process had been killed with status 9/KILL.

The service was limited to MemoryMax=60M while the workload required approximately 200 MB.

After changing the controlled lab limit to 300M, the same workload remained stable.

## INC006 — Filesystem Inode Exhaustion

File creation returned "No space left on device" while normal disk-capacity checks showed approximately 86 MB available and only 1% block usage.

df -i revealed the actual failure:

- 512 total inodes
- 512 used
- 0 free
- 100% inode utilization

After controlled cleanup, 499 inodes were free and the customer write operation succeeded again.

## Linux Diagnostic Support Bundle

The repository includes `scripts/support-bundle.sh`, an allowlisted Linux diagnostic collector.

Current version: **1.2.0**

The bundle collects:

- operating-system and host information
- uptime
- memory usage
- vmstat
- top memory-consuming processes
- top CPU-consuming processes
- kernel events
- Linux PSI memory pressure
- Linux PSI CPU pressure
- Linux PSI I/O pressure
- filesystem block usage
- inode usage
- block devices
- IP addressing
- routing
- listening sockets
- failed systemd units
- recent system errors
- Docker diagnostics when available
- Kubernetes diagnostics when available

Each diagnostic command records its exit status in the bundle manifest.

Generated archives receive a SHA-256 checksum.

## Security Controls

The diagnostic collector uses a fixed set of predefined commands and does not intentionally collect:

- private SSH keys
- `/etc/shadow`
- environment-variable dumps

Because process command lines and system/application logs may contain sensitive information, generated support bundles should be reviewed and redacted before being shared externally.

## Support Case Documentation

Each incident contains:

- customer-ticket.md
- investigation.md
- root-cause.md
- resolution.md
- customer-response.md
- engineering-escalation.md
- kb-note.md
- evidence/

The engineering escalation documents show what evidence would be supplied to engineering if an L2 investigation could not resolve the issue.

## Technical Areas Demonstrated

Linux administration, systemd, journalctl, process troubleshooting, socket diagnostics, TCP/IP, DNS, Docker, KVM/QEMU, libvirt, virtual storage, Linux cgroups, OOM analysis, ext4 filesystems, inode exhaustion, Bash diagnostics, incident triage, root-cause analysis, customer communication, knowledge-base documentation, and L2-to-engineering escalation.

## Portfolio Scope

This repository is a controlled Linux infrastructure support lab.

Failures were intentionally injected, investigated, recovered, and documented to demonstrate repeatable L2 troubleshooting methodology.

It does not represent production incidents or real customer environments.