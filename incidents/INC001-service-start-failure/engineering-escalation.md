# Engineering Escalation Package

> Escalation was not required because the controlled incident was resolved at L2. This document shows the evidence that would be supplied if engineering assistance were required.

## Customer Impact

Systemd-managed application service unable to start.

## Environment

- Ubuntu Linux
- systemd
- TCP port 18081

## Symptom

Service startup failed with:

`OSError: [Errno 98] Address already in use`

## Evidence Collected

- systemd service status
- service journal
- socket ownership
- process information
- HTTP validation
- support bundle

## Actions Already Taken

1. Reproduced the service-start failure.
2. Reviewed systemd status and journal output.
3. Isolated a TCP port conflict using `ss` and `lsof`.
4. Identified the unexpected process.
5. Removed the conflict.
6. Restarted and validated the service.

## Current Finding

Another process had already bound TCP port 18081.

## Engineering Assistance Required

If the conflicting process repeatedly returned without an identifiable local origin, engineering assistance would be requested to determine which component was spawning or re-creating the process.
