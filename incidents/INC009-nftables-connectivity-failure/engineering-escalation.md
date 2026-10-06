# Engineering Escalation

## Incident Summary

Remote application access failed because an nftables input rule blocked TCP port 18089.

## Impact

Remote clients could not establish HTTP connections to the application.

## Evidence

Healthy:

- client/server addressing
- client route
- ICMP connectivity
- server listener
- local application health

Failed:

- remote HTTP connection

Firewall evidence:

`ip saddr 10.209.0.2 tcp dport 18089 counter drop`

Observed firewall counter:

- 4 packets
- 240 bytes

## Root Cause

Incorrect nftables policy blocked required application traffic.

## Recovery

The specific blocking rule was removed while leaving the firewall chain and default policy intact.

## Validation

Remote HTTP succeeded immediately after removal of the offending rule.

No application restart was required.

## Recommended Follow-Up

- document required application ports
- peer-review firewall rule changes
- validate connectivity after firewall deployments
- monitor critical TCP endpoints
- maintain rollback procedures for firewall changes
