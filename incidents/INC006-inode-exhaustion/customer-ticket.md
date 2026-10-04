# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Application unable to create new files on the affected filesystem
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

File creation was unavailable on the affected filesystem, which could interrupt application workflows. The incident was isolated to one filesystem and there was no evidence of host-wide or multi-customer impact.

## Subject

Application reports "No space left on device" despite available disk capacity

## Customer Impact

The customer reports that an application can no longer create new files.

## Environment

- Ubuntu Linux
- ext4 filesystem
- Isolated loopback filesystem
- Mount point: /mnt/inc006

## Reported Symptom

New file creation fails with:

`No space left on device`

However, normal disk-capacity checks still show significant free space.
