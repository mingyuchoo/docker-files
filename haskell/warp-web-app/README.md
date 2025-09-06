# warp-web-app

## 개요

이 프로젝트는 `wai`/`warp` 기반의 최소 웹 애플리케이션입니다. `cabal`을 사용하여 빌드하며, Docker 멀티스테이지 빌드로 최적화된 경량 런타임 이미지를 제공합니다.

## 의존성(라이브러리)

- `http-types`
- `wai`
- `warp`

## 프로젝트 구조

```text
.
├─ exe/              # 실행 엔트리포인트 (Main.hs)
├─ test/             # 테스트 (Main.hs)
├─ index.html        # 정적 응답에 사용되는 예시 파일
├─ warp-web-app.cabal
├─ Dockerfile        # 멀티스테이지 빌드(최적화 적용)
└─ README.md
```

## 로컬에서 빌드 및 실행

### Windows PowerShell 기준

빌드

```pwsh
cabal clean
cabal build
```

실행

```pwsh
cabal run
```

테스트(테스트 모듈이 있는 경우)

```pwsh
cabal test
```

### Linux/macOS Bash 기준

빌드

```bash
cabal clean
cabal build
```

실행

```bash
cabal run
```

테스트(테스트 모듈이 있는 경우)

```bash
cabal test
```

## Docker 이미지 패키징

멀티스테이지 빌드 및 레이어 캐시 최적화가 적용된 `Dockerfile`을 사용합니다. 런타임 이미지는 `debian:bookworm-slim`을 사용하며 비루트 사용자로 동작합니다.

### 이미지 빌드

#### Windows PowerShell 기준

```pwsh
docker build . `
  --tag mingyuchoo/haskell/warp-web-app:latest

# 또는 태그를 별도로

docker build . `
  --tag warp-web-app:optimized
```

#### Linux/macOS Bash 기준

```bash
docker build . \
  --tag mingyuchoo/haskell/warp-web-app:latest

# 또는 태그를 별도로

docker build . \
  --tag warp-web-app:optimized
```

### 컨테이너 실행

#### Windows PowerShell 기준

```pwsh
# 기본 포트는 4000이며, APP_PORT 환경변수로 변경 가능
docker run --rm `
  -p 4000:4000 `
  mingyuchoo/haskell/warp-web-app:latest

# 백그라운드 실행
docker run -d `
  -p 4000:4000 `
  --name warp-web-app `
  mingyuchoo/haskell/warp-web-app:latest

# 포트/타임존 환경 변수 지정 예시
docker run --rm `
  -p 8080:8080 `
  -e APP_PORT=8080 `
  -e TZ=Asia/Seoul `
  warp-web-app:optimized
```

#### Linux/macOS Bash 기준

```bash
# 기본 포트는 4000이며, APP_PORT 환경변수로 변경 가능
docker run --rm \
  -p 4000:4000 \
  mingyuchoo/haskell/warp-web-app:latest

# 백그라운드 실행
docker run -d \
  -p 4000:4000 \
  --name warp-web-app \
  mingyuchoo/haskell/warp-web-app:latest

# 포트/타임존 환경 변수 지정 예시
docker run --rm \
  -p 8080:8080 \
  -e APP_PORT=8080 \
  -e TZ=Asia/Seoul \
  warp-web-app:optimized
```

### 브라우저에서 테스트

```text
http://localhost:4000
```

## 최적화 사항(요약)

- 멀티스테이지 빌드 유지.
- `warp-web-app.cabal`만 먼저 복사하여 `cabal build --only-dependencies`로 의존성 레이어 캐시 최적화.
- `cabal install` 시 실행 파일 스트립과 문서 비활성화로 바이너리 크기 축소.
- 런타임 이미지는 `debian:bookworm-slim` + 필요한 러ntime 라이브러리(`libgmp10`, `ca-certificates`, `tzdata`)만 설치.
- `COPY --chown`으로 별도의 `chmod/chown` 레이어 제거, 비루트(UID/GID 65532) 사용자로 실행.

추가로, `cabal.project`/`cabal.project.freeze`를 사용해 의존성 버전을 고정하면 캐시 적중률과 재현성이 더 좋아집니다.

## 트러블슈팅

- 포트 충돌: 로컬에서 4000 포트를 사용 중이라면 `-p 8080:8080 -e APP_PORT=8080`과 같이 변경하여 실행하세요.
- 타임존 반영: `-e TZ=Asia/Seoul`로 지정합니다.
- 인증서 이슈: 외부 HTTPS 통신이 필요하다면 `ca-certificates`가 포함된 런타임 이미지를 사용합니다(이미 포함).

## 참고 자료

- <https://crypto.stanford.edu/~blynn/haskell/warp.html>
- <https://stackoverflow.com/questions/22620294/minimal-warp-webserver-example>
- <https://wiki.haskell.org/Web/Servers#Warp>
