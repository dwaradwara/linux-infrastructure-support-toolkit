# Engineering Escalation

## Incident Summary

A valid PostgreSQL custom-format backup could not be restored successfully into a clean recovery environment.

## Backup Validation

SHA-256 verification:

`inc010-prod.dump: OK`

## Failure

`pg_restore --exit-on-error` returned:

`RESTORE_EXIT_CODE=1`

Error:

`role "inc010_app" does not exist`

The failing ownership operation was:

`ALTER TABLE public.orders OWNER TO inc010_app;`

## Partial State

The target had already created the `orders` table before the restore terminated.

The partially restored table was owned by `postgres`.

## Root Cause

The recovery procedure did not recreate required source database roles before restoring ownership-dependent objects.

## Recovery

A new clean target was created.

The required `inc010_app` role was provisioned before restore.

The restore then completed with exit code 0.

## Validation

- table owner: `inc010_app`
- rows restored: 10,000
- COMPLETED: 6,000
- PROCESSING: 3,000
- REFUNDED: 1,000
- source amount total: 5,039,618.05
- restored amount total: 5,039,618.05

## Recommended Follow-Up

- document required database roles in the recovery runbook
- test restores regularly on clean infrastructure
- validate backup checksums before restore
- use `--exit-on-error`
- treat partial restores as failed recovery attempts
- validate business data after technical restore completion
