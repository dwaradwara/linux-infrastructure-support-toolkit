# Root Cause

The hostname `backend.internal` had no valid local name-resolution entry.

The backend service itself was healthy and listening correctly on TCP port 18082.

Because the hostname could not resolve to an IP address, clients using `backend.internal` could not reach the service.

The issue was therefore a name-resolution failure rather than an application or network-port failure.
