# KB: PostgreSQL Backup Is Valid but Restore Fails Because a Role Is Missing

## Symptoms

- backup checksum passes
- `pg_restore` starts successfully
- restore fails during ownership operations
- error references a missing PostgreSQL role
- some database objects may already exist after failure

## Diagnostic Workflow

### 1. Validate backup integrity

`sha256sum -c <backup>.sha256`

### 2. Inspect required roles

On the source and target:

`\du`

### 3. Restore with failure detection

Use:

`pg_restore --exit-on-error`

Do not assume success because some tables were created.

### 4. Capture the exit code

A non-zero restore exit code means recovery has failed.

### 5. Inspect partial target state

Check:

- tables
- owners
- sequences
- permissions
- row counts

### 6. Correct recovery dependencies

Recreate required roles and other documented dependencies before retrying.

### 7. Restore into a clean target

Avoid layering a second recovery attempt over a partially restored database unless the procedure explicitly supports it.

## Validation

Recovery validation should include:

- restore exit code
- object ownership
- expected row counts
- business-level aggregates
- application access where applicable

## Key Principle

Backup completion is not the same as recoverability.

A backup strategy is incomplete until restore has been tested successfully on a clean environment.
