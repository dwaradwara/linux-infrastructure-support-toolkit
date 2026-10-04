# Investigation

## Reproduced Symptom

Attempting to create another file returned:

`No space left on device`

## Block Capacity

Checked filesystem block usage:

`df -h /mnt/inc006`

Observed approximately:

- Filesystem size: 92 MB
- Used: 44 KB
- Available: 86 MB
- Block usage: 1%

The filesystem therefore had substantial data-block capacity available.

## Inode Capacity

Checked inode utilization:

`df -i /mnt/inc006`

Observed:

- Total inodes: 512
- Used inodes: 512
- Free inodes: 0
- Inode utilization: 100%

## Filesystem Analysis

The affected filesystem was confirmed as an isolated ext4 loopback filesystem.

File-count and inode-consumption checks identified the controlled cache directory as the source of the inode growth.

Hundreds of small files had consumed all available filesystem inodes while using almost no block storage.

## Finding

The `ENOSPC` condition was caused by inode exhaustion rather than exhaustion of filesystem data blocks.
