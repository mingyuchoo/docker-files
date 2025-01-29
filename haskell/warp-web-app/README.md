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

## Build Docker

### How to build Docker image

```
docker build . --tag mingyuchoo/haskell/warp-web-app:latest
```

### How to run Docker Container

```
docker run -p 3000:3000 mingyuchoo/haskell/warp-web-app:latest
# or
docker run -p 3000:3000 -it mingyuchoo/haskell/warp-web-app:latest /bin/bash
```

### How to test in web browser

```
http://localhost:3000
```

## References

- <https://crypto.stanford.edu/~blynn/haskell/warp.html>
- <https://stackoverflow.com/questions/22620294/minimal-warp-webserver-example>
- <https://wiki.haskell.org/Web/Servers#Warp>
