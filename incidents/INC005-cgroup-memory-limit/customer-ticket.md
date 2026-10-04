# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Single application service repeatedly terminates under workload
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

The affected service could not remain available under its normal workload, but the issue was isolated to one service and there was no evidence of host-wide or multi-customer impact.

## Subject

Linux service terminates unexpectedly during memory-intensive workload

## Customer Impact

The customer reports that a systemd-managed application starts normally but terminates after memory usage increases.

## Environment

- Ubuntu Linux
- systemd
- cgroup resource controls
- Python workload
- Service: support-memory-demo.service

## Reported Symptom

The service starts successfully but does not remain available when memory allocation increases.
