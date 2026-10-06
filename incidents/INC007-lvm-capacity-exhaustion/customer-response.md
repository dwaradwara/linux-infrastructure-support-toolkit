# Customer Response

We identified the application write failure as a capacity issue on the LVM-backed data filesystem.

The filesystem had reached 100% utilization, while inode capacity remained healthy and the underlying LVM volume group still had approximately 1.31 GiB of unused capacity.

We extended the application logical volume and expanded the ext4 filesystem online without deleting application data.

After recovery:

- filesystem utilization decreased from 100% to 50%
- 646 MiB of filesystem capacity became available
- the previously failing 32 MiB write completed successfully
- an additional application write succeeded
- the filesystem remained mounted throughout the recovery

The application data path is operating normally again.
