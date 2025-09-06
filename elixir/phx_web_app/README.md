# PhxWebApp - Docker 최적화 가이드

## Phoenix 프로젝트 생성(참고)

```bash
mix phx.new {project-name}
cd {project-name}
mix ecto.create
mix phx.server
```

## 로컬 실행 방법(개발용)

```bash
$ mix setup
$ mix phx.server
# 또는
$ iex -S mix phx.server
```

브라우저에서 [http://localhost:4000](http://localhost:4000) 에 접속할 수 있습니다.
프로덕션 배포는 Phoenix 공식 문서를 참고하세요: [배포 가이드](https://hexdocs.pm/phoenix/deployment.html)

## Docker 이미지 패키징

### 이미지 빌드 (BuildKit/Buildx 권장)

- 최적화된 Dockerfile은 BuildKit 캐시 마운트를 사용합니다. Docker Desktop 또는 buildx 환경에서 빌드하면 캐시가 효과적으로 작동합니다.
- Windows PowerShell 예시입니다.
- 참고: Dockerfile의 빌더 이미지는 공식 elixir 이미지(OTP 28)가 다이제스트로 핀 고정되어 있어 Elixir/OTP 버전을 --build-arg로 전달할 필요가 없습니다.

```powershell
# 1) 터미널 초기화(가독성)
cls

# 2) buildx로 빌드(정책: 빌더 이미지는 Dockerfile에서 다이제스트로 고정)
Clear-Host
docker buildx build `
  --build-arg RUNNER_DEBIAN=bookworm-slim `
  -t phx-web-app:latest `
  -f Dockerfile `
  .
```

### 변경 사항 요약(중요)

- 빌더 이미지 다이제스트 고정: `elixir:otp-28@sha256:...` 형식으로 재현성 강화.
- Hex/Rebar 레이어 설치: `mix local.hex --force && mix local.rebar --force`를 캐시 마운트 없이 실행하여 빌드 중 대화형 설치 요청 방지.
- .dockerignore 업데이트: `*.lock` 제외 규칙에 대해 `!mix.lock`을 추가하여 `mix.lock`이 빌드 컨텍스트에 포함되도록 수정.
- 런타임 환경 변수: `PHX_SERVER=true` 설정 추가.

### 트러블슈팅

- 증상: `mix assets.deploy` 단계에서 다음과 같은 오류가 발생할 수 있습니다.

  ```text
  Unchecked dependencies for environment prod ... the dependency is not available, run "mix deps.get"
  ```

- 원인: `mix deps.get`이 선행되지 않았거나 `mix.lock`이 빌드 컨텍스트에서 제외된 경우 발생할 수 있습니다.
- 조치:
  - `.dockerignore`에 `!mix.lock`이 포함되어 있는지 확인합니다.
  - `Dockerfile`의 순서가 `COPY mix.exs mix.lock ./` → `mix deps.get` → `mix deps.compile` → `mix assets.deploy` 순으로 되어있는지 확인합니다.
  - 캐시로 인해 종속성 단계가 건너뛰어졌을 가능성이 있으면 아래와 같이 `--no-cache`로 재빌드합니다.

  ```powershell
  Clear-Host
  docker buildx build `
    --no-cache `
    --build-arg RUNNER_DEBIAN=bookworm-slim `
    -t phx-web-app:latest `
    -f Dockerfile `
    .
  ```

### 컨테이너 실행

- `SECRET_KEY_BASE`는 필수입니다. Phoenix 시크릿을 생성하여 환경 변수로 전달하세요.
- 데이터베이스 사용 시 `DATABASE_URL`을 함께 전달합니다.

```powershell
# 기본 실행 (포그라운드)
docker run --rm `
  -e SECRET_KEY_BASE=$(mix phx.gen.secret) `
  -p 4000:4000 `
  phx-web-app:latest

# 백그라운드 + DB 연결 예시
docker run --rm -d `
  -e SECRET_KEY_BASE=$(mix phx.gen.secret) `
  -e DATABASE_URL=ecto://postgres:postgres@postgresql-db/postgres `
  --network docker-link `
  -p 4000:4000 `
  --name phx_web_app `
  phx-web-app:latest
```

### 웹 브라우저 테스트

```text
http://localhost:4000
```

## 참고 자료

- 공식 웹사이트: <https://www.phoenixframework.org/>
- 가이드: <https://hexdocs.pm/phoenix/overview.html>
- 문서: <https://hexdocs.pm/phoenix>
- 포럼: <https://elixirforum.com/c/phoenix-forum>
- 소스: <https://github.com/phoenixframework/phoenix>
