set DOCKER_TAG=release-3_32
set DOCKER_DEPS_TAG=%DOCKER_TAG%

cd .docker

docker buildx build ^
    --build-arg DOCKER_DEPS_TAG ^
    -t "fredbill/qgis-mingw:%DOCKER_TAG%" ^
    -f qgis-mingw-fredbill.dockerfile ^
    ..
