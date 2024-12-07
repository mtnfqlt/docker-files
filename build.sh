#!/bin/bash -e

docker compose down
docker compose --progress=plain build --no-cache --pull
docker compose up
