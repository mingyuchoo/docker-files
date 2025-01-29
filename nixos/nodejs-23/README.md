# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/node-23:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/node-23:latest --file Dockerfile . --output type=tar,dest=nixos-node-23-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-node-23 mingyuchoo/nixos/node-23:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/node-23:latest
```
