# Customer Response

We confirmed that the Docker container itself was running, but the published port configuration did not match the port used by the application inside the container.

The host endpoint was forwarding traffic to container port 9000 while the application was listening on port 8000.

We recreated the container with the correct port mapping and validated the service successfully.

The endpoint is now responding normally with HTTP 200.
