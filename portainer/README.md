# Instructions

Create a docker volume to persist portainer's data or mount an external volume (like an external drive)

```console
docker volume create portainer_data

docker run --rm -d \
    --name portainer \
    -p 9000:9000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer
```

or

```console
docker-compose up -d
```

Launch portainer UI from [http://localhost:9000](http://localhost:9000)

## Reference

- [https://www.portainer.io/installation/](https://www.portainer.io/installation/)
