# Root Cause

The service was configured with an excessively restrictive systemd cgroup memory limit:

`MemoryMax=60M`

The controlled workload required approximately 200 MB.

When the service exceeded its configured cgroup limit, the process was terminated even though the Linux host still had memory available.

The issue was therefore caused by a service-level resource policy rather than general server memory exhaustion.
