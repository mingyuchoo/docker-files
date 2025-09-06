# Dream Web App

> OCaml 웹 프레임워크 Dream으로 만드는 최소 예제 프로젝트

## 프로젝트 설정

### 필수 도구 설치

- opam으로 OCaml과 dune 설치

```sh
opam install ocaml dune
```

- Dream 패키지 설치

```sh
opam install dream
```

### 프로젝트 생성

```sh
opam exec dune init project {project_name}
```

### `bin/dune` 파일에 Dream 의존성 추가

```lisp
(executable
  (public_name {project_name})
  (name main)
  (libraries {project_name} dream))
```

## `main.ml` 코드 작성

```ocaml
let () =
  Dream.run (fun _ ->
    Dream.html "Good morning, world!")
```

## 프로젝트 실행

### 빌드 및 실행

```sh
opam install --deps-only --yes .
opam exec -- dune exec $(basename ${PWD})
```

## 기능 확인

브라우저에서 [http://localhost:4000](http://localhost:4000) 으로 접속하면 "Good morning, world!" 문자열을 확인할 수 있습니다.

## Docker 빌드

### Docker 이미지 빌드 방법

```sh
docker build . --tag mingyuchoo/ocaml/dream_web_app:latest
```

### Docker 컨테이너 실행 방법

```sh
docker run -p 4000:4000 mingyuchoo/ocaml/dream_web_app:latest
# 또는
docker run -d -p 4000:4000 mingyuchoo/ocaml/dream_web_app:latest
```

### Docker 이미지 디버깅 방법

```sh
docker image ls --all
docker run -it --entrypoint /bin/bash <LAST_IMAGE_ID>
```

## 참고 자료

- [Dream Examples](https://github.com/aantron/dream/tree/master/example)
