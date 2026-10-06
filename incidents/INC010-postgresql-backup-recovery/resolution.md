# Resolution

1. Verified the backup SHA-256 checksum.
2. Reproduced the restore failure on a clean PostgreSQL 16 target.
3. Captured the non-zero `pg_restore` exit code.
4. Identified the missing `inc010_app` role.
5. Removed the partially restored recovery database.
6. Recreated a clean target database.
7. Created the required application role.
8. Re-ran `pg_restore --exit-on-error`.
9. Confirmed restore exit code 0.
10. Validated ownership, row counts, status distribution, and business totals.

## Recovery Validation

Successful restore:

- `pg_restore` exit code: 0
- `orders` owner: `inc010_app`
- restored rows: 10,000

Status distribution:

- COMPLETED: 6,000
- PROCESSING: 3,000
- REFUNDED: 1,000

Business total:

- source: 5,039,618.05
- restored: 5,039,618.05

Source and restored business state matched.

## Operational Lesson

Backup success must not be treated as proof of recoverability.

Recovery procedures must be tested in a clean environment and must document external dependencies such as database roles, ownership, permissions, extensions, and configuration.
