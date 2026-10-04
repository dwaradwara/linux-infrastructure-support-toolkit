# Root Cause

The virtual machine could not start because its configured qcow2 storage volume was missing from the path referenced by the libvirt domain definition.

Expected path:

`/var/lib/libvirt/images/lab-pool/support-vm-inc004.qcow2`

The storage file had been moved to:

`support-vm-inc004.qcow2.missing`

Because QEMU/libvirt could not access the configured disk, VM startup was blocked before the guest could boot.

The failure was therefore caused by unavailable VM storage rather than a guest operating-system or networking issue.
