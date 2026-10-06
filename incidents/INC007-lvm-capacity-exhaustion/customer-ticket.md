# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Application unable to complete new writes to its data filesystem
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

## Subject

Application writes failing because data filesystem reached capacity

## Environment

- Ubuntu 22.04 LTS
- LVM2
- ext4
- Mount point: `/mnt/inc007`
- Volume group: `inc007-vg`
- Logical volume: `inc007-app-lv`

## Reported Symptom

The application remained available but could no longer complete new file writes.

The affected filesystem reported no remaining free capacity.
