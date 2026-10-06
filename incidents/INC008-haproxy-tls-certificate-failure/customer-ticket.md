# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: HTTPS clients unable to establish a trusted connection to the application endpoint
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

## Subject

HTTPS endpoint fails certificate validation while application remains healthy

## Environment

- Ubuntu 22.04 LTS
- HAProxy 2.4
- Nginx 1.18
- Python backend application
- HTTPS frontend: `inc008.local:8443`
- Nginx proxy: `127.0.0.1:8088`
- Backend: `127.0.0.1:18088`

## Reported Symptom

Clients connecting to `https://inc008.local:8443` failed TLS certificate validation.

The backend application and Nginx proxy remained available.
