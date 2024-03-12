# Crushftp 10/11 Container build

## Getting started
You need to install
- Docker - [Install](https://docs.docker.com/get-docker/)  
- Earthly - [Install](https://earthly.dev/get-earthly)  

###  Run CrushFTP11 with docker compose
Production image:
```shell
docker compose up
```

Run app with shell
```shell
docker compose -f docker-compose-dev.yaml up
```
#### Local volume host note:
To mount the CrushFTP11 folder locally using Docker Compose, it will be mounted by default as the root user. To update the permissions of the local host volume, you can run the command ```sudo chown -R $(id -u):$(id -u) CrushFTP11``` in this repo. This command will update the permissions of the CrushFTP11 folders to use your local running user, making it easier to edit files. Otherwise, you will need to edit them with the root user on the local host machine.

### Run app with docker run
Note: All files run are accessible only within the container this way
```shell
docker run -p 8080:8080 -p 9090:9090 -p 8443:443 crushftp/crushftp11:latest
```
Default user/pass is crushadmin/password.  CHANGE IT IMMEDIATELY!  
Whether you are running in docker/docker-compose or kubernetes, you can override the entrypoint to remove the initial password or set a different temporary password.  


### Build all images and push
```
earthly --push +build-all
```

### Run Production image docker compose (dcup)
```
earthly +run
```


### Run local-dev docker with host user:
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

