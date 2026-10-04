# Root Cause

The affected ext4 filesystem exhausted all available inodes.

The filesystem contained only 512 inodes. A controlled workload generated approximately 500 small cache files, consuming the remaining inode capacity.

At failure time:

- block utilization was approximately 1%
- 86 MB of data capacity remained available
- inode utilization was 100%
- no free inodes remained

Linux requires an available inode to create a new file or directory.

Because all inodes were consumed, file creation returned `No space left on device` even though the filesystem still had available data blocks.

The root cause was therefore inode exhaustion caused by excessive creation of small files.
