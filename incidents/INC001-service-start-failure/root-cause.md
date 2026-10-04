# Root Cause

A separate Python HTTP server process was already bound to TCP port 18081.

When `support-demo.service` attempted to start, Python could not bind to the same address and exited with:

`OSError: [Errno 98] Address already in use`

This caused systemd to mark the service as failed.

The issue was therefore a port conflict rather than a systemd configuration or application-code failure.
