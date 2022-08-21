# Dockerfile

## How to build

```sh
$ docker build --tag mingyuchoo/nixos:jdk11-0.1 --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos:jdk11-0.1 --file Dockerfile . --output type=tar,dest=nixos-jdk11-0.1.tar .
```

## How to run

```sh
$ docker run --interactive --tty --rm --name nixos-jdk11 mingyuchoo/nixos:jdk11-0.1 bash
```

## How to push the image to Docker Hub

```sh
$ docker push mingyuchoo/nixos:jdk11-0.1
```