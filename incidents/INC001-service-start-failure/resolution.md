# Resolution

1. Identified the process occupying TCP port 18081.
2. Confirmed that it was not the intended systemd-managed application process.
3. Terminated the conflicting process.
4. Verified that port 18081 was free.
5. Restarted `support-demo.service`.
6. Confirmed the service entered the `active (running)` state.
7. Verified that the correct service process was listening on port 18081.
8. Performed an HTTP request and received `HTTP/1.0 200 OK`.

## Final Validation

- systemd service: active
- TCP port 18081: listening
- correct Python process: running
- HTTP response: 200 OK
