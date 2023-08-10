ARG DOCKER_DEPS_TAG=latest

FROM  fredbill/qgis-deps-mingw:${DOCKER_DEPS_TAG} AS BUILDER

COPY . /QGIS

ENV CCACHE_DIR=/QGIS/.ccache_image_build

RUN  mkdir -p /QGIS/.ccache_image_build \
  && ccache -M 1G \
  && ccache -s

WORKDIR /QGIS

RUN /QGIS/ms-windows/mingw/build.sh x86_64 nodebug
