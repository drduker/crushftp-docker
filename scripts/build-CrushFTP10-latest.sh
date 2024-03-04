#!/bin/sh
export MAJOR_VERSION=10
export DOCKER_BUILDKIT=1 #

VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}' | grep -v selected)
echo $VERSION
docker build . -f dockerfiles/Dockerfile \
--build-arg RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--build-arg MAJOR_VERSION=$MAJOR_VERSION \
--build-arg VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}') \
-t crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION -t crushftp/crushftp${MAJOR_VERSION:-11}:latest

docker push crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION
docker push crushftp/crushftp${MAJOR_VERSION:-11}:latest