# Customer Ticket
## Support Classification

- Severity: P2 (lab classification)
- Impact: Single customer-facing service unavailable
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

The affected service was unavailable, but the issue was limited to one service and there was no evidence of a platform-wide or multi-customer outage. Therefore this controlled case is classified as P2 rather than P1.

## Subject

Linux service fails to start after restart attempt

## Customer Impact

A customer reports that an application service cannot be started.

The service is unavailable and attempts to restart it fail.

## Environment

- Ubuntu Linux
- systemd-managed service
- Application port: 18081

## Reported Symptom

`support-demo.service` fails during startup.

The customer requests assistance identifying the root cause and restoring service.
