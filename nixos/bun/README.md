# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/bun:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/bun:latest --file Dockerfile . --output type=tar,dest=nixos-bun-0.1.tar .
```

## How to run

```bash
docker run --interactive --tty --rm --name nixos-bun mingyuchoo/nixos/bun:latest bash
```

## How to push the image to Docker Hub

```bash
docker push mingyuchoo/nixos/bun:latest
```
