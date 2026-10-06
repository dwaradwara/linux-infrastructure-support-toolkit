# Customer Response

We identified the recovery failure as a missing PostgreSQL application role on the clean restore environment.

The backup itself was healthy and passed SHA-256 integrity verification. However, the restore preserved source ownership metadata and required the `inc010_app` role, which had not yet been created on the recovery server.

We rebuilt the recovery target, created the required role, and repeated the restore successfully.

Validation confirmed:

- all 10,000 orders were restored
- order status counts matched the source
- source and restored total amounts both equaled 5,039,618.05
- the restored table was owned by the expected application role

The recovery has been fully validated at both database and business-data level.
