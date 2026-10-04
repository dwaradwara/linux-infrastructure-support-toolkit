# KB: Linux Service Fails With "Address Already in Use"

## Symptoms

- systemd service fails to start
- service exits immediately
- journal contains `Address already in use`

## Diagnostic Steps

1. Check service status:

`systemctl status <service>`

2. Review logs:

`journalctl -u <service>`

3. Identify the expected listening port.

4. Check existing listeners:

`ss -lntp`

5. Identify the owning process:

`lsof -iTCP:<port> -sTCP:LISTEN`

6. Verify whether the process is expected.

## Resolution

If an unintended process owns the required port, stop it safely and restart the affected service.

## Validation

Confirm:

- service is active
- correct process owns the port
- application endpoint responds successfully
