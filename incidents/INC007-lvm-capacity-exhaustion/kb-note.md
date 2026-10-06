# KB: LVM Filesystem Full While Volume Group Still Has Free Space

## Symptoms

- application writes fail
- filesystem reports 100% utilization
- logical volume is full
- volume group still reports free extents

## Diagnostic Workflow

### 1. Check filesystem usage

`df -h <mount-point>`

### 2. Check inode usage

`df -i <mount-point>`

This distinguishes block exhaustion from inode exhaustion.

### 3. Identify data growth

`du -xhd1 <mount-point>`

### 4. Confirm mount and backing device

`findmnt <mount-point>`

`lsblk`

### 5. Inspect LVM layers

`pvs`

`vgs`

`lvs`

Determine whether free capacity exists in the volume group.

## Recovery

If the volume group has sufficient free extents and the change is approved:

1. extend the logical volume
2. grow the filesystem using the filesystem-appropriate tool
3. validate capacity
4. retry the failed application operation

For ext4:

`lvextend -L +<size> <logical-volume>`

`resize2fs <logical-volume>`

## Key Principle

A full filesystem does not necessarily mean the underlying disk or LVM volume group is full.

Always identify which storage layer is constrained before taking corrective action.
