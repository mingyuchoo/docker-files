# Dockerfile

## How to build

```sh
$ docker build --tag nixos:haskell-0.1 --file Dockerfile .
# or
$ docker build --tag nixos:haskell-0.1 --file Dockerfile . --output type=tar,dest=nixos-haskell-0.1.tar .
```

## How to run

```sh
docker run --interactive --tty --rm --name nixos-haskell nixos:haskell-0.1 bash
```
