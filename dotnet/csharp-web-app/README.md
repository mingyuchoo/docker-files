# csharp-web-app

## How to build this project

```bash
  $ dotnet build
```

## How to build run this project

```bash
  $ dotnet run
```

## Packaging to image

### How to build Docker image

```bash
  $ docker build . --tag mingyuchoo/dotnet/csharp_web_app:latest
```

### How to run Docker container

```bash
  $ docker run -p 8080:8080 mingyuchoo/dotnet/csharp_web_app:latest
  # or
  $ docker run -d -p 8080:8080 mingyuchoo/dotnet/csharp_web_app:latest
```

### How to debug Docker image

```bash
  $ docker image ls --all
  $ docker run -it --entrypoint /bin/bash <LAST_IMAGE_ID>
```

## How to access this service from web browser

- `http://localhost:8080`
