# Customer Ticket

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
