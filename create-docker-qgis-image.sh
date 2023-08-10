#!/bin/bash

export DOCKER_TAG=release-3_32
export DOCKER_DEPS_TAG=${DOCKER_TAG}


set -e  # Exit on any command fails.

cd .docker
docker --version

docker buildx build \
    --pull \
    --push \
    --add-host host.docker.internal:172.17.0.1 \
    --build-arg all_proxy=http://host.docker.internal:10811 \
    --build-arg http_proxy=http://host.docker.internal:10811 \
    --build-arg https_proxy=http://host.docker.internal:10811 \
    --build-arg CC=/usr/lib/ccache/gcc \
    --build-arg CXX=/usr/lib/ccache/g++ \
    --build-arg DOCKER_DEPS_TAG \
    --cache-from "fredbill/qgis:${DOCKER_DEPS_TAG}" \
    -t "fredbill/qgis:${DOCKER_DEPS_TAG}" \
    -f qgis-fredbill.dockerfile \
    ..
