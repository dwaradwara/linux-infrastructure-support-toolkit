# Investigation

## Service Validation

Checked whether the backend service was running:

`systemctl status backend-demo.service`

The service was active.

## Port Validation

Checked the expected listening port:

`ss -lntp | grep 18082`

The backend process was listening on `127.0.0.1:18082`.

## Direct Connectivity Test

Tested the service directly by IP:

`curl -I http://127.0.0.1:18082`

The service returned HTTP 200.

This confirmed that the backend application and TCP listener were functioning.

## Name Resolution Test

Checked hostname resolution:

`getent hosts backend.internal`

No address was returned.

Checked the local hostname mapping:

`grep backend.internal /etc/hosts`

The expected mapping was missing.

## Finding

The backend service was healthy and reachable by IP, but the hostname could not be resolved.
