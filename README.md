# Crushftp 10/11 Container build

### Running docker with a local volume:
```
./local-dev-CrushFTP10.sh
```

### Run dev docker compose (dcup)
```
cd dev-compose
docker compose up
```

### Production docker run
```shell
docker run -p 8080:8080 -p 9090:9090 -p 8443:443 crushftp/crushftp10:latest
```

### Run Production docker compose (dcup)
```
docker compose up
```


### Notes
Clean up crushftp running/exited containers
```shell
docker rm $(docker ps -a |grep crushftp | awk '{print $1}') --force
```

Setting password on startup:
```shell
java -jar CrushFTP.jar -a crushadmin password
or
java -jar CrushFTP.jar -ad crushadmin password
```
