# Fast-web-app

## How to create Python project

```
$ uv init {project-name}
$ cd {project-name}
$ uv venv --python 3.13
$ source .venv/bin/activate
$ uv pip add  fastapi uvicorn
$ uv pip freeze > requirements.txt
# Implement main.py
$ uv run -- uvicorn main:app --reload
```

## How to build this project

```
$ uv venv --python 3.13
$ source .venv/bin/activate
$ uv pip install .
```

## How to run this project

```
$ uv run -- uvicorn main:app --reload
```

## Build Docker

### How to build Docker image

```
docker build . --tag mingyuchoo/python/fast-web-app:latest
```

### How to run Docker Container

```
docker run -p 4000:4000 mingyuchoo/python/fast-web-app:latest
# or
docker run -d -p 4000:4000 mingyuchoo/python/fast-web-app:latest
```

