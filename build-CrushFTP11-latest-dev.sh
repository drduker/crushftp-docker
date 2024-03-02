#!/bin/sh
export MAJOR_VERSION=11
export DOCKER_BUILDKIT=1 #

# VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}' | grep -v selected)
VERSION=beta
echo $VERSION
docker build . -f CrushFTP11-local.Dockerfile \
--build-arg RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--build-arg MAJOR_VERSION=$MAJOR_VERSION \
--build-arg VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}') \
-t crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION-dev -t crushftp/crushftp${MAJOR_VERSION:-11}:latest-dev

docker push crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION-dev
docker push crushftp/crushftp${MAJOR_VERSION:-11}:latest-dev