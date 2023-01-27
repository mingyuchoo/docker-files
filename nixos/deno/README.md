# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos:deno-0.1 --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos:deno-0.1 --file Dockerfile . --output type=tar,dest=nixos-deno-0.1.tar .
```

## How to run

```bash
docker run --interactive --tty --rm --name nixos-deno mingyuchoo/nixos:deno-0.1 bash
```

## How to push the image to Docker Hub

```bash
docker push mingyuchoo/nixos:deno-0.1
```
