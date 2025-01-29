# nix-app

## Build Locally

### How to build this code

```
cabal clean
cabal build
```

### How to run this code

```
cabal run
```

## Build Docker

### Build this app

```bash
stack build
stack exec nix-app.exe
nix-build default.nix
```

### Build Docker image

```bash
cd docker
nix-build default.nix
docker load -i result
```

### Run Docker

```bash
docker run -p 8000:8000 nix-app:<HASH>
```

### How to check health

```bash
$ curl -X POST \
    -H "Content-Type: text/plain;charset=utf-8" \
    -H "Accept: application/json;charset=utf-8" \
    -d "lorum ipsum dolor sit amet" \
    http://localhost:8000/words

{"words":["lorum","ipsum","dolor","sit","amet"]}
```

## References

- <https://www.williamyaoh.com/posts/2019-04-09-deploying-haskell-with-ecs-and-nix.html>
