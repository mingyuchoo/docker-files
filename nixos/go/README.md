# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/go:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/go:latest --file Dockerfile . --output type=tar,dest=nixos-go-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-go mingyuchoo/nixos/go:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/go:latest
```