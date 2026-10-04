# Resolution

1. Verified the backend systemd service was active.
2. Confirmed TCP port 18082 was listening.
3. Confirmed direct access through 127.0.0.1 returned HTTP 200.
4. Identified that `backend.internal` did not resolve.
5. Restored the required hostname mapping.
6. Verified hostname resolution with `getent`.
7. Re-tested the application using the hostname.

## Final Validation

- Backend service: active
- TCP port 18082: listening
- `backend.internal`: resolves to 127.0.0.1
- HTTP request through hostname: 200 OK
