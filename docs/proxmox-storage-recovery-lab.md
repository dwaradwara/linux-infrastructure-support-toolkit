# Proxmox VE and Storage Recovery Lab

## Overview

This lab extends the Linux Infrastructure Support Toolkit with hands-on Proxmox VE, ZFS, and Linux software RAID administration.

The environment was intentionally nested for controlled infrastructure testing:

Windows 11 -> WSL2 -> KVM/libvirt -> Proxmox VE -> Ubuntu VM

## Proxmox VE

Deployed Proxmox VE 9.2.2 on a nested KVM/libvirt virtual machine.

Validated:

- Proxmox Web UI and CLI administration
- `qm` VM lifecycle management
- nested KVM acceleration
- LVM-thin storage
- Linux bridge networking with `vmbr0`
- Cloud-Init provisioning
- VirtIO networking
- QEMU guest agent integration
- VM start, stop, reboot, and snapshots

Created Ubuntu VM 100 (`ubuntu-pve-01`) with:

- Ubuntu 24.04 LTS
- 1 vCPU
- 1 GB RAM
- 8 GB virtual disk
- DHCP networking
- SSH key authentication
- QEMU guest agent

## Proxmox Backup and Recovery

Performed a controlled VM disaster-recovery exercise.

Workflow:

1. Created a snapshot-mode `vzdump` backup.
2. Verified backup integrity with SHA-256.
3. Shut down the VM.
4. Intentionally destroyed VM 100.
5. Confirmed the VM configuration no longer existed.
6. Restored VM 100 using `qmrestore`.
7. Booted the restored VM.
8. Validated hostname, networking, disk configuration, and QEMU guest-agent communication.

The restored VM returned successfully as `ubuntu-pve-01`.

## ZFS Mirror Recovery

Added two dedicated virtual disks and created a ZFS mirror.

Healthy state:

- pool: `tank`
- topology: mirror
- members: `/dev/vdb1` and `/dev/vdc1` initially
- state: ONLINE

A 100 MB test file was written and protected with a SHA-256 checksum.

Failure test:

1. Took one mirror member offline.
2. Confirmed the pool entered `DEGRADED` state.
3. Verified existing data remained readable.
4. Successfully wrote new data while degraded.
5. Added a replacement virtual disk.
6. Replaced the failed member.
7. Allowed ZFS resilvering to complete.
8. Ran a ZFS scrub.

Final state:

- pool: ONLINE
- mirror members healthy
- scrub repaired 0 bytes
- no known data errors
- original checksum remained valid
- data written while degraded survived recovery

## Linux RAID1 Recovery

Created `/dev/md0` using `mdadm` RAID1 across two dedicated 3 GB virtual disks.

Healthy state:

- RAID level: RAID1
- active devices: 2
- health: `[UU]`
- filesystem: ext4

A 100 MB test file was written and protected with SHA-256.

Failure test:

1. Marked one RAID member failed.
2. Removed the failed member.
3. Confirmed the array entered `clean, degraded` state.
4. Confirmed RAID health changed to `[U_]`.
5. Verified existing data remained readable.
6. Wrote additional data while degraded.
7. Attached a replacement disk.
8. Added the replacement to `/dev/md0`.
9. Allowed RAID rebuilding to complete.

Final state:

- array: clean
- active devices: 2
- working devices: 2
- failed devices: 0
- original checksum remained valid
- degraded-mode write survived recovery

## Skills Demonstrated

- Proxmox VE administration
- KVM/QEMU virtualization
- Cloud-Init
- QEMU guest agent
- LVM-thin storage
- Linux bridges and VirtIO networking
- VM snapshots
- `vzdump` backup
- `qmrestore` recovery
- ZFS pools and mirrors
- ZFS degraded-state troubleshooting
- disk replacement and resilvering
- ZFS scrub validation
- Linux `mdadm` RAID1
- degraded RAID operation
- RAID member replacement and rebuild
- storage integrity validation with SHA-256

This is a controlled lab environment and does not represent production Proxmox, ZFS, or RAID administration.
