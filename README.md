# Run standalone Nailgun in Docker

This project allows to run standalone [Nailgun](https://github.com/openstack/fuel-web) in Docker.

## Run Nailgun

Build image

```
cd nailgun-docker
docker build -t nailgun-docker 9.1
```

Run container

```
docker run --name nailgun -d nailgun-docker
```

## Use Nailgun

Attach with interactive shell

```
docker exec -i -t nailgun /bin/bash
fuel node
```

Run single command

```
docker exec nailgun fuel node
```

## TODO

  * Support older versions

## Known issues
