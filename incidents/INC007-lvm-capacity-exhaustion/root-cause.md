# Root Cause

The application data filesystem exhausted all available block capacity because its LVM logical volume was undersized for the controlled workload.

The logical volume was initially provisioned at 700 MiB while the application generated approximately 610 MiB of log data plus additional files.

At failure time:

- filesystem utilization: 100%
- filesystem available space: 0
- inode utilization: approximately 1%
- logical volume size: 700 MiB
- free space in the volume group: 1.31 GiB

The underlying LVM volume group was not full.

The failure occurred because available volume-group capacity had not been allocated to the application logical volume.

A subsequent 32 MiB write could not complete and left only a partial file.

The root cause was therefore insufficient logical-volume capacity rather than overall storage exhaustion.
