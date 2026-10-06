# Root Cause

The PostgreSQL recovery failed because the target environment did not contain the application role `inc010_app`.

The backup preserved object ownership metadata from the source database.

During restore, PostgreSQL attempted to execute:

`ALTER TABLE public.orders OWNER TO inc010_app;`

Because the role did not exist on the recovery server, `pg_restore` terminated with exit code 1.

The backup itself was valid and passed SHA-256 integrity verification.

The root cause was therefore an incomplete recovery procedure that did not recreate required database roles before restoring ownership-dependent database objects.

A valid backup alone was insufficient to guarantee successful recovery.
