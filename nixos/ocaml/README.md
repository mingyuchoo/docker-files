# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/ocaml:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/ocaml:latest --file Dockerfile . --output type=tar,dest=nixos-ocaml-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-ocaml mingyuchoo/nixos/ocaml:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/ocaml:latest
```