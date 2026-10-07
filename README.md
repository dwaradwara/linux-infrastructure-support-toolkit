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
| INC007 | LVM / filesystem capacity | Application logical volume exhausted while volume group still had free capacity | df, du, lsblk, findmnt, pvs, vgs, lvs, resize2fs |
| INC008 | HAProxy / Nginx / TLS | Certificate SAN did not match the HTTPS service hostname | curl, openssl s_client, haproxy -c, nginx -t, ss, systemctl |
| INC009 | nftables / networking | Firewall rule blocked TCP/18089 while routing, ICMP, listener, and local application remained healthy | ip, ping, ss, curl, nft |
| INC010 | PostgreSQL backup / recovery | Valid backup restore failed because required application role was missing; recovery validated with checksum, ownership, row counts, and business totals | pg_dump, pg_restore, psql, sha256sum, Docker |

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

## INC007 — LVM Filesystem Capacity Exhaustion

An LVM-backed application filesystem reached 100% utilization and could no longer complete new writes.

Investigation separated the storage layers using `df`, `df -i`, `du`, `findmnt`, `lsblk`, `pvs`, `vgs`, and `lvs`.

At failure time:

- filesystem size: 672 MiB
- filesystem utilization: 100%
- available filesystem capacity: 0
- inode utilization: approximately 1%
- logical volume size: 700 MiB
- volume-group free capacity: approximately 1.31 GiB

The underlying volume group still had substantial unused capacity, proving that the constrained layer was the application logical volume and filesystem.

The logical volume was extended by 700 MiB and the ext4 filesystem was grown online with `resize2fs`.

After recovery:

- logical volume size: approximately 1.37 GiB
- filesystem size: approximately 1.4 GiB
- filesystem utilization: 50%
- available capacity: 646 MiB
- the previously failing 32 MiB write completed successfully
- an additional application write succeeded

No application data was deleted during recovery.

## INC008 - HAProxy TLS Certificate Identity Failure

The HTTPS frontend failed strict hostname validation while the backend application, Nginx, and HAProxy remained healthy.

During the incident:

- backend application: healthy
- Nginx: healthy
- HAProxy: active
- HAProxy configuration: valid
- TCP 8443: listening
- TLS handshake: successful
- requested hostname: `inc008.local`
- presented certificate SAN: `DNS:wrong-inc008.local`
- strict client validation: failed with curl error 60

The failure was isolated to certificate hostname identity rather than application availability, reverse-proxy availability, TCP reachability, or TLS negotiation.

The known-good certificate containing `DNS:inc008.local` was restored. HAProxy configuration was validated before reload, and strict HTTPS validation then succeeded without disabling certificate verification.

## INC009 - nftables Network Connectivity Failure

A remote client could not reach an application even though the server remained reachable and the application was healthy locally.

During the incident:

- client and server IP configuration: correct
- client route: correct
- ICMP reachability: successful
- application listener: healthy on TCP 18089
- local HTTP request: successful
- remote HTTP request: timed out
- nftables drop counter: 4 packets / 240 bytes

The fault was isolated to an nftables rule explicitly dropping TCP traffic from the client to the application port.

The specific blocking rule was removed without disabling the firewall or restarting the application. The original remote HTTP request then succeeded.

## INC010 - PostgreSQL Backup and Recovery Validation

A PostgreSQL custom-format backup passed SHA-256 integrity validation but failed when restored into a clean recovery environment.

The first recovery attempt failed because the source application role `inc010_app` did not exist on the target server.

`pg_restore --exit-on-error` returned exit code `1` while processing object ownership:

`ALTER TABLE public.orders OWNER TO inc010_app;`

The failed attempt also demonstrated that a restore can leave partial database state behind.

Recovery was repeated from a clean target after recreating the required database role.

Final validation confirmed:

- backup checksum: valid
- `pg_restore` exit code: 0
- restored table owner: `inc010_app`
- restored rows: 10,000
- COMPLETED orders: 6,000
- PROCESSING orders: 3,000
- REFUNDED orders: 1,000
- source total amount: 5,039,618.05
- restored total amount: 5,039,618.05

The incident demonstrates that successful backup creation alone does not prove recoverability. Recovery procedures must also validate dependencies, ownership, permissions, restore exit status, and recovered business data.

## Ansible Linux Baseline Automation

The repository also includes an Ansible role for repeatable Linux baseline configuration on an Ubuntu KVM/libvirt VM.

The automation manages:

- operational packages with APT
- users and groups
- filesystem ownership and permissions
- Chrony service state
- a Linux health-check utility
- an infrastructure baseline marker

The first deployment completed with:

```text
ok=8 changed=6 unreachable=0 failed=0
```

A second execution with no desired-state changes completed with:

```text
ok=8 changed=0 unreachable=0 failed=0
```

This validates repeatable, idempotent configuration management with Ansible.

Implementation and execution evidence are available under `ansible/`.



## Proxmox VE and Storage Recovery Lab

Additional infrastructure exercises cover hands-on Proxmox VE administration and storage recovery:

- nested Proxmox VE 9.2.2 deployment
- Cloud-Init Ubuntu VM provisioning
- QEMU guest-agent integration
- VM snapshot, `vzdump` backup, destruction, and `qmrestore` recovery
- ZFS mirror degradation, disk replacement, resilver, and scrub
- `mdadm` RAID1 degradation, member replacement, and rebuild

See `docs/proxmox-storage-recovery-lab.md` for the complete lab summary.

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

Linux administration, systemd, journalctl, process troubleshooting, socket diagnostics, TCP/IP, DNS, Docker, KVM/QEMU, libvirt, virtual storage, Linux cgroups, OOM analysis, ext4 filesystems, inode exhaustion, LVM physical volumes, volume groups and logical volumes, online filesystem expansion, Bash diagnostics, incident triage, root-cause analysis, customer communication, knowledge-base documentation, and L2-to-engineering escalation.

## Portfolio Scope

This repository is a controlled Linux infrastructure support lab.

Failures were intentionally injected, investigated, recovered, and documented to demonstrate repeatable L2 troubleshooting methodology.

It does not represent production incidents or real customer environments.
