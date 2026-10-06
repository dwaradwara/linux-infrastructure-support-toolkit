# Investigation

## IP Configuration

Client:

`10.209.0.2/24`

Server:

`10.209.0.1/24`

Both interfaces were UP.

## Routing

The client routing table contained:

`10.209.0.0/24 dev inc009-cli-veth`

The route to the server network was therefore correct.

## Network Reachability

ICMP testing from client to server succeeded with 0% packet loss.

This confirmed basic Layer 3 connectivity.

## Application Listener

`ss -lntp`

confirmed the application was listening on:

`10.209.0.1:18089`

## Local Application Test

A request executed inside the server namespace returned:

`{"status":"ok","service":"inc009-network-app"}`

The application itself was therefore healthy.

## Remote Client Test

The client request to:

`http://10.209.0.1:18089/`

timed out after approximately 3 seconds.

## Firewall Investigation

`nft -a list ruleset`

revealed:

`ip saddr 10.209.0.2 tcp dport 18089 counter drop`

The rule counter recorded:

- packets: 4
- bytes: 240

## Finding

The failure was isolated to nftables.

IP addressing, routing, host reachability, the listening socket, and the application were all healthy.

TCP traffic from the client to port 18089 was being explicitly dropped by the server firewall.
