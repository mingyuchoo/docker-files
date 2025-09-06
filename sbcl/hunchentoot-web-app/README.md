# README

## 프로젝트 설정

### 프로젝트 생성

```sh
mkdir {project-name}
cd {project-name}
```

### 필수 도구 설치

Quicklisp를 사용하여 SBCL 환경을 준비합니다.

```sh
curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(ql:add-to-init-file)' --eval '(quit)'
```

### 프로젝트 초기화

```sh
mkdir -p src
touch src/main.lisp
```

### hunchentoot 패키지 설치

SBCL REPL에서 Quicklisp로 설치합니다.

```sh
sbcl
(ql:quickload "hunchentoot")
```

## `main.lisp` 코드 작성

다음 코드를 `src/main.lisp`에 작성합니다.

```commonlisp
;; Quicklisp 로드
(load "~/quicklisp/setup.lisp")

;; Hunchentoot 서버 로드
(ql:quickload "hunchentoot")

;; 패키지 정의
(defpackage :my-web-server
  (:use :cl :hunchentoot))
(in-package :my-web-server)

;; 간단한 핸들러 정의
(define-easy-handler (hello :uri "/") ()
  (setf (hunchentoot:content-type*) "text/plain")
  "Hello, World!")

;; 웹 서버 실행
(defvar *my-server*
  (hunchentoot:start
    (make-instance 'hunchentoot:easy-acceptor :address "0.0.0.0" :port 4000)))

(format t "Server started on http://0.0.0.0:4000~%")

(loop (sleep 60))
```

## 프로젝트 실행

```sh
sbcl --load src/main.lisp
```

## 기능 확인

브라우저에서 다음 주소로 접속하여 `Hello, World!` 문자열이 출력되는지 확인합니다.

- <http://localhost:4000>

## Docker 빌드 및 실행

### Docker 이미지 빌드

```sh
docker build . --tag mingyuchoo/sbcl/hunchentoot-web-app:latest
```

### Docker 컨테이너 실행

```sh
docker run -p 4000:4000 mingyuchoo/sbcl/hunchentoot-web-app:latest
# 또는
docker run -d -p 4000:4000 mingyuchoo/sbcl/hunchentoot-web-app:latest
```

### Docker 이미지 디버깅

```sh
docker image ls --all
docker run -it --entrypoint /bin/bash <LAST_IMAGE_ID>
```

## 참고 자료

- <https://www.quicklisp.org/beta/>
