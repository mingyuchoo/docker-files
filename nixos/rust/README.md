# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/rust:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/rust:latest --file Dockerfile . --output type=tar,dest=nixos-rust-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-rust mingyuchoo/nixos/rust:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/rust:latest
```
