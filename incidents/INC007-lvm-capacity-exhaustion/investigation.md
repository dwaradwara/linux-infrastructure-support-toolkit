# Investigation

## Reported Symptom

The application data path could no longer complete new writes.

The affected filesystem was mounted at:

`/mnt/inc007`

## Filesystem Capacity

`df -h /mnt/inc007`

showed:

- filesystem size: 672 MiB
- used: 623 MiB
- available: 0
- utilization: 100%

## Inode Check

`df -i /mnt/inc007`

showed approximately 1% inode utilization.

This ruled out inode exhaustion.

## Data Growth

`du -xhd1 /mnt/inc007`

showed approximately 623 MiB under the application-data directory.

The primary contributor was:

`application.log` - 610 MiB

## LVM Analysis

LVM inspection showed:

- physical volume: `/dev/loop5p1`
- volume group: `inc007-vg`
- logical volume: `inc007-app-lv`
- logical volume size: 700 MiB
- free space remaining in volume group: 1.31 GiB

The underlying volume group therefore still had substantial unused capacity.

## Finding

The application filesystem had reached 100% block utilization because the logical volume allocated to it was too small for the controlled workload.

The incident was not caused by:

- inode exhaustion
- an unmounted filesystem
- exhaustion of the underlying volume group
- loss of the backing device

The constrained layer was the logical volume and its ext4 filesystem.
