# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Remote clients unable to reach the application service
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

## Subject

Application is healthy locally but remote clients cannot connect

## Environment

- Ubuntu Linux
- Isolated Linux network namespaces
- Client IP: `10.209.0.2`
- Server IP: `10.209.0.1`
- Application port: `18089`
- Firewall: nftables

## Reported Symptom

The application remained healthy on the server, but remote HTTP requests from the client timed out.

Basic network reachability remained available.
