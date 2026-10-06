# Resolution

The incorrect HAProxy certificate was replaced with the previously validated certificate for:

`inc008.local`

The restored certificate contained:

- Common Name: `inc008.local`
- Subject Alternative Name: `DNS:inc008.local`

Before reload, the HAProxy configuration was validated using:

`haproxy -c -f /etc/haproxy/haproxy.cfg`

HAProxy was then reloaded without stopping the backend application or Nginx.

## Recovery Validation

After recovery:

- backend application remained active
- Nginx remained active
- HAProxy remained active
- HAProxy configuration remained valid
- certificate CN matched `inc008.local`
- certificate SAN contained `DNS:inc008.local`
- direct backend health check succeeded
- Nginx health check succeeded
- strict HTTPS certificate validation succeeded

No TLS verification bypass was required during final validation.
