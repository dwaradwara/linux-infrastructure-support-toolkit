# Resolution

1. Confirmed the container was running.
2. Reproduced the failed customer request.
3. Inspected Docker port publishing.
4. Inspected the container command and logs.
5. Identified the mismatch between container port 9000 and application port 8000.
6. Removed the incorrectly configured container.
7. Recreated it with:

`127.0.0.1:18083 -> container:8000`

8. Verified the container was running.
9. Verified the corrected Docker port mapping.
10. Confirmed the customer endpoint returned HTTP 200.

## Final Validation

- Container: Running
- Application process: listening on port 8000
- Published mapping: 18083 -> 8000
- HTTP endpoint: 200 OK
