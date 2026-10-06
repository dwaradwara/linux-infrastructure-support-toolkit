# Customer Ticket

## Support Classification

- Severity: P2 (lab classification)
- Impact: Database recovery could not complete successfully
- Urgency: High
- SLA: Simulated support scenario; no production SLA applies

## Subject

PostgreSQL backup is valid but recovery fails on clean target

## Environment

- PostgreSQL 16
- Docker-isolated source and recovery instances
- Source database: `inc010_prod`
- Recovery database: `inc010_restore`
- Application role: `inc010_app`
- Backup format: PostgreSQL custom format
- Integrity validation: SHA-256

## Reported Symptom

A PostgreSQL custom-format backup passed checksum validation, but restore into a clean recovery environment failed before the database could be considered recovered.

## Business Data

Source database contained:

- 10,000 orders
- 6,000 COMPLETED
- 3,000 PROCESSING
- 1,000 REFUNDED
