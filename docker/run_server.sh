#!/usr/bin/env bash
set -euo pipefail

# Usage: run_server.sh <server-name> <project-dir> <host-port> <runtime>
NAME="${1:?server name required}"
PROJECT="${2:?project directory required}"
PORT="${3:?host port required}"
RUNTIME="${4:-python}"

case "$RUNTIME" in
  python) IMAGE="ne-host-python-server"; DOCKERFILE="python-server.Dockerfile";;
  nodejs) IMAGE="ne-host-node-server"; DOCKERFILE="node-server.Dockerfile";;
  *) echo "Unsupported runtime" >&2; exit 2;;
esac

docker build --pull -t "$IMAGE" -f "$(dirname "$0")/$DOCKERFILE" "$PROJECT"
docker rm -f "ne-server-$NAME" >/dev/null 2>&1 || true
docker network create --internal "ne-net-$NAME" >/dev/null 2>&1 || true

docker run -d --name "ne-server-$NAME" \
  --network "ne-net-$NAME" \
  --publish "127.0.0.1:${PORT}:8000" \
  --user 10001:10001 --memory=512m --memory-swap=512m --cpus=0.50 --pids-limit=128 \
  --ulimit nofile=1024:1024 --ulimit nproc=128:128 \
  --cap-drop=ALL --security-opt=no-new-privileges:true --security-opt=seccomp=default \
  --ipc=private --uts=private --read-only --tmpfs /tmp:rw,noexec,nosuid,nodev,size=64m \
  --restart=unless-stopped \
  "$IMAGE"

echo "Started ne-server-$NAME on localhost:$PORT"
