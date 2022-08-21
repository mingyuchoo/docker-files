# Dockerfile

## How to build

```sh
$ docker build --tag mingyuchoo/nixos:deno-0.1 --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos:deno-0.1 --file Dockerfile . --output type=tar,dest=nixos-deno-0.1.tar .
```

## How to run

```sh
$ docker run --interactive --tty --rm --name nixos-deno nixos:deno-0.1 bash
```

## How to push the image to Docker Hub

```sh
$ docker push mingyuchoo/nixos:deno-0.1
```