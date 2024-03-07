# Crushftp 10/11 Container build




### Production docker run
Note: All files run and accessible only within the container this way
```shell
docker run -p 8080:8080 -p 9090:9090 -p 8443:443 crushftp/crushftp11:latest
```
Default user/pass is crushadmin/password.  CHANGE IT IMMEDIATELY!

### Run local-dev with a local volume with host user:
```
docker run -p 8081:8080 -p 9091:9090 -p 8443:443 \
-v "$(pwd)/CrushFTP11:/app/CrushFTP11:rw" -u $(id -u) \
crushftp/crushftp11:local-dev
```

### Run Production image docker compose (dcup)
```
earthly +run
```
or
```
docker compose up
```


### Running docker with a local volume with host user:
```
./scripts/local-dev-CrushFTP11.sh
```

### Notes
Clean up crushftp running/exited containers
```shell
docker rm $(docker ps -a |grep crushftp | awk '{print $1}') --force
```

