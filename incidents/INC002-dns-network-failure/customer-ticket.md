# Customer Ticket
## Support Classification

- Severity: P2 (lab classification)
- Impact: Customer workflow unable to reach backend by hostname
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

### Severity Rationale

The hostname-based workflow was unavailable, but the backend service itself remained operational and reachable directly by IP. The issue was therefore significant but not a platform-wide outage.

## Subject

Application cannot connect to backend service by hostname

## Customer Impact

The customer reports that requests to `backend.internal` fail.

The backend service is expected to be available on TCP port 18082.

## Environment

- Ubuntu Linux
- systemd-managed backend service
- Backend hostname: backend.internal
- Backend port: 18082

## Reported Symptom

Connections using the backend hostname fail even though the backend application is expected to be running.
