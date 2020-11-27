#!/usr/bin/env bash

set -e
set -x

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin quay.io

docker-compose -f docker-compose.build.yml build

docker-compose -f docker-compose.build.yml push
