# KB: Application Works Locally but Remote Connection Times Out

## Symptoms

- application works locally
- service process is running
- expected TCP port is listening
- host responds to ping
- remote application connection times out

## Diagnostic Workflow

### 1. Verify IP addressing

`ip addr`

### 2. Verify routing

`ip route`

### 3. Test basic reachability

`ping <server-ip>`

### 4. Verify listening ports

`ss -lntp`

### 5. Test the application locally

`curl http://<server-ip>:<port>/`

### 6. Test from the remote client

`curl -v --connect-timeout 3 http://<server-ip>:<port>/`

### 7. Inspect firewall policy

`nft -a list ruleset`

Look for rules matching:

- source IP
- destination IP
- protocol
- destination port
- accept/drop action
- packet counters

## Key Principle

Successful ping does not prove that an application port is reachable.

ICMP and TCP can be controlled independently by firewall policy.

Likewise, a listening socket does not prove that remote clients can reach it.

Troubleshoot each layer independently:

`IP -> route -> reachability -> listener -> local app -> firewall -> remote app`

## Recovery

Correct only the confirmed firewall rule and repeat the original client request.

Do not disable the entire firewall as a troubleshooting shortcut.
