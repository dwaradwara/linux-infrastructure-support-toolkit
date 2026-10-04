# KB: Service Works by IP but Fails by Hostname

## Symptoms

- application is running
- expected TCP port is listening
- direct IP connection works
- hostname-based connection fails

## Diagnostic Workflow

1. Check application/service status:

`systemctl status <service>`

2. Verify expected port:

`ss -lntp`

3. Test direct IP connectivity:

`curl http://<ip>:<port>`

4. Test name resolution:

`getent hosts <hostname>`

5. Inspect resolver configuration:

`cat /etc/resolv.conf`

6. Check local hostname mappings:

`grep <hostname> /etc/hosts`

7. Check routes if required:

`ip route`

## Key Principle

If direct IP connectivity succeeds but hostname access fails, investigate DNS/name resolution before restarting the application.

## Validation

Confirm both:

- hostname resolves to the expected address
- application responds successfully using the hostname
