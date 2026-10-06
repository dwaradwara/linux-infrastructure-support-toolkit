# Investigation

## Architecture

Traffic path:

`HTTPS client -> HAProxy :8443 -> Nginx :8088 -> application :18088`

## Service State

All services remained active:

- backend application: active
- Nginx: active
- HAProxy: active

HAProxy configuration validation returned:

`Configuration file is valid`

## Backend Validation

Direct backend request:

`curl http://127.0.0.1:18088/health`

returned HTTP success.

Nginx request:

`curl http://127.0.0.1:8088/health`

also returned HTTP success.

This ruled out the application and Nginx layers.

## TLS Investigation

A strict HTTPS request to:

`https://inc008.local:8443/health`

completed the TLS handshake but failed hostname verification.

The presented certificate contained:

- Common Name: `wrong-inc008.local`
- Subject Alternative Name: `DNS:wrong-inc008.local`

The requested hostname was:

`inc008.local`

curl returned error 60:

`SSL: no alternative certificate subject name matches target host name 'inc008.local'`

## Finding

The TLS endpoint itself was available and HAProxy remained healthy.

The incident was caused by a certificate identity mismatch between the hostname requested by the client and the DNS identity contained in the certificate.
