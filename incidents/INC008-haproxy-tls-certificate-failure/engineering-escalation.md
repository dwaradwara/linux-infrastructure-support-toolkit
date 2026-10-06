# Engineering Escalation

## Incident Summary

Strict HTTPS clients failed certificate validation on the HAProxy frontend.

## Impact

Clients validating the endpoint hostname could not establish a trusted HTTPS connection.

## Evidence

During the incident:

- backend application: active
- Nginx: active
- HAProxy: active
- HAProxy configuration: valid
- port 8443: listening
- backend health check: successful
- Nginx health check: successful
- TLS handshake: successful
- requested hostname: `inc008.local`
- certificate CN: `wrong-inc008.local`
- certificate SAN: `DNS:wrong-inc008.local`
- curl result: error 60 hostname mismatch

## Failure Domain

The issue was isolated to certificate identity at the HAProxy TLS termination layer.

## Recovery

The incorrect certificate was replaced with the validated certificate for `inc008.local`, HAProxy configuration was checked, and the service was reloaded.

## Validation

After recovery:

- CN: `inc008.local`
- SAN: `DNS:inc008.local`
- backend health: successful
- Nginx health: successful
- strict HTTPS health check: successful

## Recommended Follow-Up

- validate CN/SAN before certificate deployment
- automate certificate expiry and identity checks
- validate HAProxy configuration before reload
- maintain documented certificate rollback procedures
- monitor HTTPS endpoints using strict certificate verification
