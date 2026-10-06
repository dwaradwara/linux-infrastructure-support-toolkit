# Resolution

The affected logical volume was extended online by 700 MiB:

`lvextend -L +700M /dev/inc007-vg/inc007-app-lv`

The ext4 filesystem was then expanded online:

`resize2fs /dev/inc007-vg/inc007-app-lv`

No application data was deleted.

## Recovery Validation

After the change:

- logical volume size: approximately 1.37 GiB
- filesystem size: approximately 1.4 GiB
- filesystem utilization: 50%
- available filesystem capacity: 646 MiB
- free volume-group capacity: 644 MiB
- inode utilization: approximately 1%

The same 32 MiB write that previously failed completed successfully.

A new post-recovery application write also succeeded.

The filesystem remained mounted throughout the recovery.
