# Crushftp 10/11 Container build


### Production docker run
Note: All files run are accessible only within the container this way
```shell
docker run -p 8080:8080 -p 9090:9090 -p 8443:443 crushftp/crushftp11:latest
```
Default user/pass is crushadmin/password.  CHANGE IT IMMEDIATELY!  
Whether you are running in docker/docker-compose or kubernetes, you can override the entrypoint to remove the initial password or set a different temporary password.  


### Run Production image docker compose (dcup)
Earthly is required for image builds - [Install](https://earthly.dev/get-earthly)  
```
earthly +run
```
or
```
docker compose up
```

### Build all images and push
```
earthly --push +build-all
```

### Running docker with a local volume with host user:
```
./scripts/local-dev-CrushFTP11.sh
```

### Run local-dev with a local volume with host user:
```
docker run -p 8081:8080 -p 9091:9090 -p 8443:443 \
-v "$(pwd)/CrushFTP11:/app/CrushFTP11:rw" -u $(id -u) \
crushftp/crushftp11:local-dev
```
### Notes
Clean up crushftp running/exited containers forcefully:
```shell
docker rm $(docker ps -a |grep crushftp | awk '{print $1}') --force
```

