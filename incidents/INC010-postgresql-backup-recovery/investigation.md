# Investigation

## Backup Integrity

The custom-format PostgreSQL backup was validated using:

`sha256sum -c inc010-prod.dump.sha256`

Result:

`inc010-prod.dump: OK`

The backup file itself was therefore not corrupted.

## Recovery Target

A clean PostgreSQL 16 recovery environment was created.

Role inspection showed only the default `postgres` role.

The source application role:

`inc010_app`

did not exist.

## Restore Attempt

The restore was executed using:

`pg_restore --exit-on-error`

The operation failed with exit code:

`1`

Error:

`ERROR: role "inc010_app" does not exist`

The failing statement was:

`ALTER TABLE public.orders OWNER TO inc010_app;`

## Partial Restore State

After failure, the `orders` table existed but was owned by:

`postgres`

This demonstrated that the restore had partially modified the target before terminating.

## Finding

The backup was valid, but the recovery environment was incomplete.

The restore depended on a PostgreSQL role that existed on the source system but had not been recreated on the clean recovery target.

The failure was therefore caused by an unfulfilled recovery dependency rather than backup corruption.
