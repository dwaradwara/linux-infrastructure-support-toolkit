# Customer Response

We confirmed that the backend service itself was running normally and responding successfully when accessed directly by IP.

The issue was isolated to hostname resolution for `backend.internal`. The required hostname mapping was missing, which prevented clients from resolving the backend address.

The mapping has been restored and connectivity through the hostname has been validated successfully with an HTTP 200 response.

No backend application restart or application-code change was required.
