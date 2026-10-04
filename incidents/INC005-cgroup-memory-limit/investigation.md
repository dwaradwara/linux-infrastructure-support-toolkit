# Investigation

## Service State

Reviewed the service with:

`systemctl status support-memory-demo.service`

The service had previously terminated while processing a controlled memory workload.

## Service Logs

Reviewed:

`journalctl -u support-memory-demo.service`

The workload progressively allocated memory before the process was terminated.

## Host Memory

Checked host-level memory using:

`free -m`

The host still had available memory.

This indicated that the failure was not caused by complete host-wide memory exhaustion.

## Resource Policy

Inspected systemd resource configuration:

`systemctl show support-memory-demo.service -p MemoryMax -p MemoryCurrent`

The service had:

`MemoryMax=60M`

The workload required substantially more memory than that limit.

## Kernel / cgroup Evidence

Kernel and systemd logs were reviewed for OOM and cgroup-related termination evidence.

## Finding

The application was constrained by the service-specific cgroup memory limit rather than the total physical memory available on the host.
