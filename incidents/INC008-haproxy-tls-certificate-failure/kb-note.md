# KB: HTTPS Failure Caused by Certificate Hostname Mismatch

## Symptoms

- HTTPS clients fail certificate verification
- HAProxy remains active
- TCP port remains listening
- backend application remains healthy
- Nginx remains healthy
- TLS handshake may still succeed

## Diagnostic Workflow

### 1. Validate backend

`curl http://127.0.0.1:<backend-port>/health`

### 2. Validate Nginx

`nginx -t`

`curl http://127.0.0.1:<nginx-port>/health`

### 3. Validate HAProxy configuration

`haproxy -c -f /etc/haproxy/haproxy.cfg`

### 4. Confirm listener

`ss -lntp`

### 5. Inspect certificate

`openssl s_client -connect <host>:<port> -servername <hostname>`

Inspect:

- subject
- issuer
- validity dates
- Subject Alternative Name

### 6. Perform strict client validation

Use curl without `-k`.

A successful TLS handshake does not prove that certificate hostname validation is correct.

## Key Principle

Separate:

- application availability
- reverse-proxy availability
- TCP reachability
- TLS negotiation
- certificate trust
- certificate hostname identity

These are different failure domains.

## Recovery

Deploy the correctly issued certificate, validate configuration before reload, then repeat strict HTTPS validation.

Do not use `curl -k` as proof of production recovery because it disables certificate verification.
