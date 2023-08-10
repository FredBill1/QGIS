#!/bin/bash

export DOCKER_TAG=release-3_32
export DOCKER_DEPS_TAG=${DOCKER_TAG}


set -e  # Exit on any command fails.

cd .docker
docker --version

docker buildx build \
    --pull \
    --push \
    --build-arg all_proxy=http://host.docker.internal:10811 \
    --build-arg http_proxy=http://host.docker.internal:10811 \
    --build-arg https_proxy=http://host.docker.internal:10811 \
    --cache-from "fredbill/qgis-deps-mingw:${DOCKER_DEPS_TAG}" \
    -t "fredbill/qgis-deps-mingw:${DOCKER_DEPS_TAG}" \
    -f qgis-deps-mingw-fredbill.dockerfile \
    ..
