# Resolution

1. Confirmed the service termination.
2. Reviewed service and kernel logs.
3. Verified that host-level memory remained available.
4. Inspected the systemd resource policy.
5. Identified `MemoryMax=60M` as insufficient for the workload.
6. Increased the controlled lab limit to `MemoryMax=300M`.
7. Reloaded systemd configuration.
8. Restarted the service.
9. Re-ran the same workload.
10. Confirmed the process allocated approximately 200 MB and remained running.

## Final Validation

- Service: active (running)
- MemoryCurrent: approximately 204 MB
- MemoryMax: 300 MB
- Workload completed controlled allocation
- Result: success
