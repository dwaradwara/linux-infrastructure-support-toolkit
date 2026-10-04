# Customer Response

We identified that the application was being terminated after exceeding its configured systemd memory limit.

Host-level memory remained available, which allowed us to isolate the issue to the service's cgroup resource policy rather than general server memory exhaustion.

The service-specific memory limit was adjusted and the same workload was repeated successfully.

The application is now stable at approximately 200 MB of memory usage and remains in the active running state.
