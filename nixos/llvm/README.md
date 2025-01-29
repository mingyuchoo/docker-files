# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/llvm:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/llvm:latest --file Dockerfile . --output type=tar,dest=nixos-llvm-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-llvm mingyuchoo/nixos/llvm:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/llvm:latest
```
