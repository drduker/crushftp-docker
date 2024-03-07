#!/bin/sh
export DOCKER_BUILDKIT=1
export MAJOR_VERSION=11
VERSION=$(curl -s https://www.crushftp.com/version11_build.html | head -n 1| awk '{print $2}' | grep -v selected)
echo $VERSION
docker build . -f dockerfiles/local-user-volume.Dockerfile \
--build-arg RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--build-arg MAJOR_VERSION=$MAJOR_VERSION \
--build-arg VERSION=$(curl -s https://www.crushftp.com/version11_build.html | head -n 1| awk '{print $2}') \
-t crushftp/crushftp11:local-dev || exit 1

# docker run -p 8081:8080 -p 9091:9090 -p 8443:443 \
# -v "$(pwd)/CrushFTP11:/app/CrushFTP11:rw" -u $(id -u) \
# crushftp/crushftp11:local-dev

docker run -p 8081:8080 -p 9091:9090 -p 8443:443 \
-v "$(pwd)/CrushFTP11:/app/CrushFTP11:rw" -u root \
crushftp/crushftp11:local-dev