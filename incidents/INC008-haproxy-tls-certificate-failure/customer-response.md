# Customer Response

We identified the HTTPS failure as a certificate hostname mismatch at the HAProxy TLS termination layer.

The application, Nginx proxy, HAProxy service, and network listener remained healthy throughout the incident.

HAProxy was presenting a certificate for `wrong-inc008.local` while clients were connecting to `inc008.local`.

We restored the certificate containing the correct `inc008.local` DNS identity, validated the HAProxy configuration, and reloaded the service.

Strict HTTPS validation now succeeds and the application health endpoint is available normally.
