# KB: Docker Container Running but Service Is Unreachable

## Symptoms

- `docker ps` reports container as Running
- application endpoint is unreachable
- container may not show an obvious crash

## Diagnostic Workflow

1. Check container state:

`docker ps -a`

2. Test the customer endpoint:

`curl -v http://<host>:<port>`

3. Check published ports:

`docker port <container>`

4. Inspect container configuration:

`docker inspect <container>`

5. Check application logs:

`docker logs <container>`

6. Compare:

- application listening port
- Docker container port
- host published port

## Key Principle

A Running Docker container only confirms that its main process is alive. It does not prove that the application is reachable through the configured network path.

## Resolution

Correct the Docker port mapping so the host forwards traffic to the actual application listener.

## Validation

Confirm:

- container remains Running
- correct port mapping is present
- endpoint returns the expected HTTP response
