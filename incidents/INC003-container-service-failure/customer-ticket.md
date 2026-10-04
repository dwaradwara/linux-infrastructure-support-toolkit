# Customer Ticket
## Support Classification

- Severity: P2 (lab classification)
- Impact: Containerized customer service unreachable through published endpoint
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

The customer-facing endpoint was unavailable, but the impact was isolated to one containerized service and there was no evidence of broader infrastructure failure.

## Subject

Docker container is running but application service is unreachable

## Customer Impact

The customer reports that a containerized service cannot be reached through the expected host endpoint.

Docker reports the container as running, but requests to port 18083 fail.

## Environment

- Ubuntu Linux
- Docker
- Container: support-container-demo
- Host endpoint: 127.0.0.1:18083
- Application port inside container: 8000

## Reported Symptom

The container appears healthy from Docker's process-level perspective, but the application is unavailable through the published host port.
