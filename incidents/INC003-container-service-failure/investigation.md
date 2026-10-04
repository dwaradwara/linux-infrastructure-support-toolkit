# Investigation

## Container State

Checked the container:

`docker ps -a --filter name=support-container-demo`

The container was running.

## Customer Endpoint Test

Tested:

`curl -I http://127.0.0.1:18083`

The request failed with:

`Recv failure: Connection reset by peer`

## Port Mapping Inspection

Checked Docker's published ports:

`docker port support-container-demo`

Docker reported:

`9000/tcp -> 127.0.0.1:18083`

## Application Process Inspection

Inspected the container command:

`docker inspect support-container-demo`

The application command started Python HTTP Server on port 8000.

Container logs confirmed:

`Serving HTTP on 0.0.0.0 port 8000`

## Finding

The container itself was running, but Docker forwarded host port 18083 to container port 9000 while the application listened on port 8000.
