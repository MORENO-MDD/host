# Docker isolation for NE HOST

The current sandbox does not have Docker installed, so these files are deployment-ready but cannot be executed here. The Flask control panel remains Python and should be deployed on a Linux host with Docker Engine enabled.

Each project should run in its own container and its own private Docker network. Use `run_server.sh` with the server folder, public host port, and runtime:

```bash
chmod +x docker/run_server.sh
docker/run_server.sh demo /srv/ne-host/instances/demo 13506 python
docker/run_server.sh demo-node /srv/ne-host/instances/demo-node 13507 nodejs
```

The runner applies a non-root user, dropped Linux capabilities, `no-new-privileges`, a read-only root filesystem, a small writable `/tmp`, CPU/RAM/PID limits, localhost-only host binding, and automatic restart. A reverse proxy should expose the public domain and forward to the localhost port.

For stronger production isolation, run Docker rootless where practical, keep the Docker socket inaccessible to the web process, validate and limit uploads, restrict outbound network access with a firewall or egress proxy, scan archives before extraction, and never mount the host Docker socket into a project container. The control panel must call the runner through a tightly scoped service account rather than allowing arbitrary shell commands.

Because Docker is unavailable in this sandbox, this is not a claim that container isolation is active on the temporary demo link. It becomes active only after deployment on a Docker-enabled host and integration of the runner into the server lifecycle.
