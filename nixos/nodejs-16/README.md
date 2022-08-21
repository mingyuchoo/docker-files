# Dockerfile

## How to build

```sh
$ docker build --tag nixos:node16-0.1 --file Dockerfile .
# or
$ docker build --tag nixos:node16-0.1 --file Dockerfile . --output type=tar,dest=nixos-node16-0.1.tar .
```

## How to run

```sh
docker run --interactive --tty --rm --name nixos-node16 nixos:node16-0.1 bash
```
