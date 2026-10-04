# KB: libvirt VM Fails to Start Because Storage File Is Missing

## Symptoms

- VM exists in `virsh list --all`
- VM remains shut off
- `virsh start` fails
- error references an inaccessible or missing storage file

## Diagnostic Workflow

1. Check VM state:

`virsh list --all`

2. Reproduce the start failure:

`virsh start <vm>`

3. Inspect attached disks:

`virsh domblklist <vm>`

4. Inspect domain XML:

`virsh dumpxml <vm>`

5. Verify the configured storage path:

`ls -lh <disk-path>`

6. Inspect the relevant storage pool or directory.

7. Review libvirt/QEMU logs when required.

## Key Principle

A valid VM definition does not guarantee that its dependent storage resources are available.

Troubleshoot the hypervisor, storage, and guest layers separately.

## Resolution

Restore or correct the virtual disk referenced by the VM definition, then retry VM startup.

## Validation

Confirm:

- expected virtual disk exists
- libvirt reports the correct block device
- VM starts successfully
- VM state becomes Running
