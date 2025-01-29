# Dockerfile

## How to build

```bash
$ docker build --tag mingyuchoo/nixos/elixir:latest --file Dockerfile .
# or
$ docker build --tag mingyuchoo/nixos/elixir:latest --file Dockerfile . --output type=tar,dest=nixos-elixir-0.1.tar .
```

## How to run

```bash
$ docker run --interactive --tty --rm --name nixos-elixir mingyuchoo/nixos/elixir:latest bash
```

## How to push the image to Docker Hub

```bash
$ docker push mingyuchoo/nixos/elixir:latest
```