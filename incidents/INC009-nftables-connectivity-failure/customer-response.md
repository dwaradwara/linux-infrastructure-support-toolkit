# Customer Response

We identified the connectivity issue as an incorrect firewall rule on the application server.

The application itself remained healthy, the server was reachable over the network, and the expected TCP port was listening. However, nftables was dropping client traffic to the application port.

We removed only the affected firewall rule and repeated the original remote request.

Following recovery:

- network reachability remained healthy
- the application remained available
- remote HTTP connectivity was restored
- no application restart was required

The service is now reachable normally from the client network.
