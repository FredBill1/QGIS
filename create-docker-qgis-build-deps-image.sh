#!/bin/bash

export DOCKER_TAG=release-3_32
export DOCKER_DEPS_TAG=${DOCKER_TAG}
export DOCKER_BUILD_DEPS_FILE=qgis3-qt5-build-deps-fredbill.dockerfile


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
    --cache-from "fredbill/qgis3-build-deps:${DOCKER_DEPS_TAG}" \
    -t "fredbill/qgis3-build-deps:${DOCKER_DEPS_TAG}" \
    -f ${DOCKER_BUILD_DEPS_FILE} \
    .
