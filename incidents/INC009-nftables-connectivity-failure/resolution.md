# Resolution

1. Verified client and server IP configuration.
2. Confirmed the client route to the server network.
3. Confirmed ICMP connectivity.
4. Verified the application listener on TCP 18089.
5. Confirmed the application was healthy locally.
6. Reproduced the remote connection timeout.
7. Inspected the nftables ruleset.
8. Identified the drop rule affecting TCP 18089.
9. Removed only the offending firewall rule.
10. Repeated remote connectivity testing.

## Final Validation

After recovery:

- routing remained correct
- ping remained successful
- application remained listening on TCP 18089
- local HTTP remained healthy
- remote HTTP succeeded
- no blocking rule remained in the nftables input chain

The application did not require a restart.
