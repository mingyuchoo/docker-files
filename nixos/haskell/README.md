# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/haskell:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/haskell:latest --file Dockerfile . --output type=tar,dest=nixos-haskell-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-haskell mingyuchoo/nixos/haskell:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/haskell:latest
```
