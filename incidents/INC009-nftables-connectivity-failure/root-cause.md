# Root Cause

An nftables input rule explicitly dropped TCP traffic from the client IP `10.209.0.2` to application port `18089`.

The affected rule was:

`ip saddr 10.209.0.2 tcp dport 18089 counter drop`

During the incident:

- client and server IP configuration was correct
- routing was correct
- ICMP connectivity succeeded
- the application was listening on the expected address and port
- local application requests succeeded
- remote HTTP requests timed out
- the nftables rule counter increased as connection attempts were made

The root cause was therefore an incorrect firewall rule blocking the required application port.
