# Customer Ticket

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
