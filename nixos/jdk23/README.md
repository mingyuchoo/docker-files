# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/jdk23:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/jdk23:latest --file Dockerfile . --output type=tar,dest=nixos-jdk23-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-jdk23 mingyuchoo/nixos/jdk23:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/jdk23:latest
```
