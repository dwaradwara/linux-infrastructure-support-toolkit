# Investigation

## Initial Triage

Checked the systemd service state:

`systemctl status support-demo.service`

The service had exited with a failure status.

## Log Analysis

Reviewed the service journal:

`journalctl -u support-demo.service`

The logs showed:

`OSError: [Errno 98] Address already in use`

This indicated that the application could not bind to its configured TCP port.

## Port Investigation

Checked port ownership using:

`ss -lntp`

and:

`lsof -iTCP:18081 -sTCP:LISTEN`

A separate Python process was already listening on port 18081.

## Finding

The systemd service itself was correctly configured, but another process had already claimed its required TCP port.
