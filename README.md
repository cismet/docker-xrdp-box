# docker-xrdp-box
Docker file for a ubuntu mate desktop box 

* with a preinstalled (but not yet autostart enabled Dropbox client)
* Java 8

just use it with 

```bash
docker run -d -p 3389:3389 --name=xrdp cismet/xrdp-box
```

add users to a running container (no secrets in the image)

```bash
docker exec -it xrdp-ubuntu bash -c "useradd -ms /bin/bash $username"
docker exec -it xrdp-ubuntu bash -c "echo $username:$password|chpasswd "
```



