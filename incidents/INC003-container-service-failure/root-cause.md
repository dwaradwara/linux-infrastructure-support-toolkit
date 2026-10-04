# Root Cause

The Docker container had an incorrect published-port configuration.

Configured forwarding:

`127.0.0.1:18083 -> container:9000`

Actual application listener:

`container:8000`

Because Docker forwarded traffic to a container port where no application was listening, customer requests failed even though the container remained in the Running state.

The issue was a container networking configuration error rather than an application process failure.
