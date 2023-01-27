# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos:jdk11-0.1 --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos:jdk11-0.1 --file Dockerfile . --output type=tar,dest=nixos-jdk11-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-jdk11 mingyuchoo/nixos:jdk11-0.1 bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos:jdk11-0.1
```