# Crushftp 10/11 Container build

### Set versions of build
Default if not set is 11
```bash
export MAJOR_VERSION=10
export DOCKER_BUILDKIT=1 # used to turn on buildkit if not already turned on
# IF CrushFTP 11 `export VERSION=beta`
```

## dev (with shell)
```shell
VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}' | grep -v selected)

docker build . -f local.Dockerfile \
--build-arg RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--build-arg VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}') \
-t crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION-dev -t crushftp/crushftp${MAJOR_VERSION:-11}:latest-dev

docker push crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION-dev
docker push crushftp/crushftp${MAJOR_VERSION:-11}:latest-dev
```
### dev local docker run
```shell
docker run -p 8081:8080 -p 9091:9090 -p 8443:443 \
-v "$(pwd)/CrushFTP${MAJOR_VERSION:-11}:/app/CrushFTP${MAJOR_VERSION:-11}:rw" -u $(id -u) \
crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION-dev
```

### Run dev docker compose (dcup)
```
cd dev-compose
docker compose up
```

## Production (distroless)
```shell
VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}' | grep -v selected)

docker build . -f Dockerfile \
--build-arg RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
--build-arg VERSION=$(curl -s https://www.crushftp.com/version${MAJOR_VERSION:-11}_build.html | head -n 1| awk '{print $2}') \
-t crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION -t crushftp/crushftp${MAJOR_VERSION:-11}:latest

docker push crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION
docker push crushftp/crushftp${MAJOR_VERSION:-11}:latest
```

### Production local docker run
```shell
docker run -p 8081:8080 -p 9091:9090 -p 8443::443 \
-v "$(pwd)/CrushFTP${MAJOR_VERSION:-11}:/app/CrushFTP${MAJOR_VERSION:-11}:rw" -u $(id -u) \
crushftp/crushftp${MAJOR_VERSION:-11}:$VERSION
```

### Run Production docker compose (dcup)
```
docker compose up
```


### Notes
Slean up crushftp running/exited containers
```shell
docker rm $(docker ps -a |grep crushftp | awk '{print $1}') --force
```

Setting password on startup:
```shell
java -jar CrushFTP.jar -a crushadmin password
```
<!-- docker run -p 8888:8080 \
-v "$(pwd)/users:/app/users:rw" \
-v "$(pwd)/backup:/app/backup:rw" \
-v "$(pwd)/syncsDB:/app/syncsDB:rw" \
-v "$(pwd)/statsDB:/app/statsDB:rw" \
-v "$(pwd)/logs:/app/logs:rw" \
-v "$(pwd)/jobs:/app/jobs:rw" \
-v "$(pwd)"/prefs.xml:/app/prefs.xml:rw \
test:test -->

