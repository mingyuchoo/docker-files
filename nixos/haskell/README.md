# Dockerfile

## How to build

```sh
$ docker build --tag mingyuchoo/nixos:haskell-0.1 --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos:haskell-0.1 --file Dockerfile . --output type=tar,dest=nixos-haskell-0.1.tar .
```

## How to run

```sh
$ docker run --interactive --tty --rm --name nixos-haskell mingyuchoo/nixos:haskell-0.1 bash
```

## How to push the image to Docker Hub

```sh
$ docker push mingyuchoo/nixos:haskell-0.1
```