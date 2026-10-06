# Root Cause

HAProxy was configured with a TLS certificate issued for the wrong DNS identity.

The application endpoint was expected to serve:

`inc008.local`

but HAProxy presented a certificate containing:

`CN=wrong-inc008.local`

and:

`DNS:wrong-inc008.local`

The certificate was otherwise structurally valid and the TLS handshake succeeded.

However, hostname verification correctly failed because the certificate Subject Alternative Name did not contain `inc008.local`.

The failure was therefore not caused by:

- backend application availability
- Nginx availability
- HAProxy service failure
- HAProxy configuration syntax
- TCP listener failure
- TLS protocol negotiation

The root cause was incorrect certificate identity deployment at the HAProxy TLS termination layer.
