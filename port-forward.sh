#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="prod-story"

forwards=(
  "svc/prod-story-psql-postgresql-ha 5454:5432"
  "svc/prod-story-redis-haproxy 6363:6379"
  "svc/reels-meilisearch 7700:7700"
)

pids=()

cleanup() {
  for pid in "${pids[@]:-}"; do
    if kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null || true
    fi
  done
  wait || true
}

trap cleanup EXIT INT TERM

start_forward() {
  local target="$1"
  while true; do
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] starting: kubectl -n $NAMESPACE port-forward $target"
    kubectl -n "$NAMESPACE" port-forward $target &
    local pf_pid=$!
    wait "$pf_pid" || true
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] stopped: kubectl -n $NAMESPACE port-forward $target"
    sleep 2
  done
}

for forward in "${forwards[@]}"; do
  start_forward "$forward" &
  pids+=("$!")
  sleep 0.2
 done

wait
