# README

## How to create a Axum web project

```bash
cargo new {project-name}
cd {project-name}
cargo add tokio --features=macros,rt-multi-thread
cargo add clap --features=derive
cargo add axum

# edit ./src/main.rs

cargo run -- --port 4000
cargo check
cargo test
cargo build --release
./target/release/{project-name}
```

## Packaging to image

### How to build Docker image

```bash
docker build . --tag mingyuchoo/rust/axum-web-app:latest
```

### How to run Docker container

```bash
docker run -p 4000:4000 mingyuchoo/rust/axum-web-app:latest
# or
docker run -d -p 4000:4000 mingyuchoo/rust/axum-web-app:latest
```

---

## 프로젝트 개요

이 저장소는 `axum` 기반의 간단한 웹 애플리케이션 예제입니다. 기본 라우팅과 CLI 포트 설정을 제공하며, 최적화된 멀티스테이지 Docker 빌드를 포함합니다.

## 디렉터리 구조

```text
./
├─ Cargo.toml                # 패키지/의존성 정의
├─ Cargo.lock                # 잠금 파일(실행형 바이너리이므로 포함됨)
├─ src/
│  └─ main.rs               # 애플리케이션 엔트리포인트 및 라우팅
├─ Dockerfile                # 멀티스테이지 빌드 / 캐시 최적화 / 슬림 런타임
├─ Makefile.toml             # cargo-make 작업 정의
├─ .dockerignore             # Docker 컨텍스트 제외 목록
├─ .gitignore                # Git 제외 목록
├─ rust-toolchain.toml       # nightly 채널 및 개발 툴체인 구성
├─ rustfmt.toml, leptosfmt.toml, .taplo.toml # 포맷터 설정
└─ README.md
```

## 주요 의존성

- `axum = 0.7.5`
- `tokio = 1.41.1` (features: `full`)
- `clap = 4.5.20` (features: `derive`)

`src/main.rs`는 다음 라우트를 제공합니다:

- `GET /` → "Hello, World from Rust!"
- `POST /echo` → 요청 바디를 그대로 반환
- `GET /hey` → "Hey there!"

## 로컬 실행

```bash
cargo run -- --port 4000
```

기본 포트는 `4000`이며, `--port` 플래그로 변경할 수 있습니다.

## 테스트/빌드

```bash
cargo check
cargo test
cargo build --release
```

## Makefile 작업(cargo-make)

`Makefile.toml`에 다음 작업이 정의되어 있습니다.

- `clean` → `cargo clean`
- `clippy` → `cargo clippy`
- `check` → `cargo check`
- `format` → `cargo fmt` (선행: check, clippy)
- `build` → `cargo build` (선행: format)
- `test` → `cargo test` (선행: format)
- `run` → `cargo run` (선행: format)

설치: `cargo install cargo-make`

## 엔드포인트 확인 예시

### Bash

```bash
# 루트
curl -s http://localhost:4000/

# 에코(POST)
curl -s -X POST http://localhost:4000/echo -d 'hello'

# hey
curl -s http://localhost:4000/hey
```

### PowerShell

```pwsh
# 루트
Invoke-RestMethod -Method GET http://localhost:4000/

# 에코(POST)
Invoke-RestMethod -Method POST http://localhost:4000/echo -Body 'hello' -ContentType 'text/plain'

# hey
Invoke-RestMethod -Method GET http://localhost:4000/hey
```

## Docker 빌드/실행 (최적화 Dockerfile 기준)

이 프로젝트의 `Dockerfile`은 다음을 포함합니다:

- 멀티스테이지 빌드(`chef`→`planner`→`builder`→`runtime`)
- `cargo-chef`로 의존성 캐시 최적화
- BuildKit 캐시 마운트(`cargo registry`, `target`)
- 릴리스 빌드 후 `strip`으로 바이너리 최소화
- `alpine` 슬림 런타임 + 비루트 사용자 실행

### 빌드(옵션 인자 지정 가능)

- Bash

```bash
docker build . \
  -t mingyuchoo/rust/axum-web-app:latest \
  --build-arg RUST_VERSION=1.89.0 \
  --build-arg TARGET=x86_64-unknown-linux-musl \
  --build-arg APP_NAME=axum-web-app
```

- PowerShell (줄바꿈 이슈를 피하기 위해 한 줄 권장)

```pwsh
Clear-Host
docker build . -t mingyuchoo/rust/axum-web-app:latest `
--build-arg RUST_VERSION=1.89.0 `
--build-arg TARGET=x86_64-unknown-linux-musl `
--build-arg APP_NAME=axum-web-app
```

### 실행

- Bash

```bash
docker run --rm \
  -p 4000:4000 \
  --name axum-web-app \
  -e APP_PORT=4000 \
  mingyuchoo/rust/axum-web-app:latest
```

- PowerShell

```pwsh
Clear-Host
docker run --rm `
  -p 4000:4000 `
  --name axum-web-app `
  -e APP_PORT=4000 `
  mingyuchoo/rust/axum-web-app:latest
```

### 로그 확인

- Bash

```bash
docker logs -f axum-web-app
```

- PowerShell

```pwsh
Clear-Host
docker logs -f axum-web-app
```

## 개발 도구/설정

- `rust-toolchain.toml`에서 `nightly` 채널과 `clippy`, `rustfmt`, `rust-analyzer`, `rust-src`가 설정되어 있습니다.
- 코드 포맷은 `rustfmt.toml` 및 기타 포맷 설정 파일에 따릅니다.
- `.dockerignore`를 통해 Docker 컨텍스트 크기를 줄였습니다.

## 참고

- 애플리케이션 기본 포트는 `4000`입니다. 컨테이너 실행 시 `-p 4000:4000`으로 매핑하세요.
- Docker 빌드 속도 향상을 위해 Docker BuildKit 사용을 권장합니다.
