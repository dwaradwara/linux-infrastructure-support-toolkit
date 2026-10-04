# Investigation

## VM State

Checked the domain:

`virsh list --all`

The VM definition existed but the VM was shut off.

## Start Attempt

Attempted:

`virsh start support-vm-inc004`

libvirt returned:

`Cannot access storage file ... No such file or directory`

## Storage Inspection

Checked the VM block-device configuration:

`virsh domblklist support-vm-inc004`

The VM expected:

`/var/lib/libvirt/images/lab-pool/support-vm-inc004.qcow2`

The domain XML confirmed the same disk source.

## Filesystem Validation

The expected qcow2 file was not present at the configured path.

Inspection of the storage directory showed the disk under an unexpected filename:

`support-vm-inc004.qcow2.missing`

## Finding

The VM definition remained valid, but its configured virtual disk was unavailable at the expected filesystem path.
