# Express-web-app

## How to create Nodejs project

```bash
$ fnm install 23
$ fnm use 23
$ mkdir express-web-app
$ cd express-web-app
$ npm init -y
$ npm add express
# Implement index.js
$ node index.js
```

## How to build this project

```bash
$ cd express-web-app
$ fnm install 23
$ fnm use 23
$ npm install 
```

## How to run this project

```bash
$ node index.js
```

## Packaging to image

### How to build Docker image

```bash
docker build . --tag mingyuchoo/nodejs/express-web-app:latest
```

### How to run Docker container

```bash
docker run -p 4000:4000 mingyuchoo/nodejs/express-web-app:latest
# or
docker run -d -p 4000:4000 mingyuchoo/nodejs/express-web-app:latest
```

