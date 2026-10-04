# KB: Linux Service Killed Despite Available Host Memory

## Symptoms

- service starts normally
- service terminates when memory use increases
- server may still show available RAM
- restarting the service only reproduces the failure

## Diagnostic Workflow

1. Check service state:

`systemctl status <service>`

2. Review service logs:

`journalctl -u <service>`

3. Check host memory:

`free -m`

4. Inspect service resource limits:

`systemctl show <service> -p MemoryCurrent -p MemoryMax`

5. Review kernel memory events:

`journalctl -k`

6. Inspect the unit configuration:

`systemctl cat <service>`

## Key Principle

Available physical memory does not mean every process is allowed to consume it.

systemd/cgroup policies can impose service-specific limits that cause a process to be terminated while the host still has free memory.

## Resolution

Correct the resource policy only after confirming that the workload's memory consumption is expected.

Do not simply raise limits without first ruling out abnormal application memory growth.

## Validation

Confirm:

- service remains active
- memory usage stays within the revised limit
- host memory remains healthy
- workload completes successfully
