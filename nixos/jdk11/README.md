# Dockerfile

## How to build

```sh
$ docker build --tag nixos:jdk11-0.1 --file Dockerfile .
# or
$ docker build --tag nixos:jdk11-0.1 --file Dockerfile . --output type=tar,dest=nixos-jdk11-0.1.tar .
```

## How to run

```sh
docker run --interactive --tty --rm --name nixos-jdk11 nixos:jdk11-0.1 bash
```
