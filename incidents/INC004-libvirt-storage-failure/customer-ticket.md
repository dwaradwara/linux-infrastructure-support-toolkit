# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Single virtual machine unable to start
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

The affected virtual machine was unavailable, but the incident was isolated to a single VM and there was no evidence of hypervisor-wide or multi-customer impact.

## Subject

Virtual machine fails to start due to inaccessible storage volume

## Customer Impact

The customer reports that a previously defined virtual machine cannot be started.

## Environment

- Linux KVM/QEMU
- libvirt
- VM: support-vm-inc004
- Storage pool: lab-pool
- Disk format: qcow2

## Reported Symptom

`virsh start support-vm-inc004` fails and the VM remains shut off.
