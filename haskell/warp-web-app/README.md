# warp-web-app

## Dependencies

- `http-types`
- `wai`
- `warp`

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

## Packaging to image

### How to build Docker image

```
docker build . --tag mingyuchoo/haskell/warp-web-app:latest
```

### How to run Docker container

```
docker run -p 4000:4000 mingyuchoo/haskell/warp-web-app:latest
# or
docker run -d -p 4000:4000 mingyuchoo/haskell/warp-web-app:latest
```

### How to test in web browser

```
http://localhost:4000
```

## References

- <https://crypto.stanford.edu/~blynn/haskell/warp.html>
- <https://stackoverflow.com/questions/22620294/minimal-warp-webserver-example>
- <https://wiki.haskell.org/Web/Servers#Warp>
