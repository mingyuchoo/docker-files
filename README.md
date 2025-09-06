# docker-files

다양한 프로그래밍 언어와 프레임워크로 작성된 샘플 웹 애플리케이션을 Docker로 빌드/실행하기 위한 예시 모음입니다. 각 디렉터리에는 최소 구현의 앱, `Dockerfile`, 그리고 개별 `README.md`가 포함되어 있습니다.

<p align="center">
  <a href="https://github.com/mingyuchoo/docker-files/blob/main/LICENSE"><img alt="license" src="https://img.shields.io/github/license/mingyuchoo/docker-files"/></a>
  <a href="https://github.com/mingyuchoo/docker-files/issues"><img alt="Issues" src="https://img.shields.io/github/issues/mingyuchoo/docker-files?color=appveyor" /></a>
  <a href="https://github.com/mingyuchoo/docker-files/pulls"><img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/mingyuchoo/docker-files?color=appveyor" /></a>
</p>

아래 목록은 현재 리포지토리에 포함된 프로젝트와 기본 노출 포트, 권장 이미지 태그를 요약합니다. 상세 사용법은 각 프로젝트의 README를 참고하세요.

## 프로젝트 목록

- C# ASP.NET Core Web App
  - 경로: `dotnet/csharp-web-app/`
  - Dockerfile: `dotnet/csharp-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/dotnet/csharp_web_app:latest`
  - 기본 포트: `8080`
  - 문서: `dotnet/csharp-web-app/README.md`

- F# ASP.NET Core Web App
  - 경로: `dotnet/fsharp-web-app/`
  - Dockerfile: `dotnet/fsharp-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/dotnet/fsharp_web_app:latest`
  - 기본 포트: `8080`
  - 문서: `dotnet/fsharp-web-app/README.md`

- Node.js Express Web App
  - 경로: `nodejs/express-web-app/`
  - Dockerfile: `nodejs/express-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/nodejs/express-web-app:latest`
  - 기본 포트: `4000`
  - 문서: `nodejs/express-web-app/README.md`

- Python FastAPI Web App
  - 경로: `python/fast-web-app/`
  - Dockerfile: `python/fast-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/python/fast-web-app:latest`
  - 기본 포트: `4000`
  - 문서: `python/fast-web-app/README.md`

- Rust Axum Web App
  - 경로: `rust/axum-web-app/`
  - Dockerfile: `rust/axum-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/rust/axum-web-app:latest`
  - 기본 포트: `4000`
  - 문서: `rust/axum-web-app/README.md`

- Haskell Warp Web App
  - 경로: `haskell/warp-web-app/`
  - Dockerfile: `haskell/warp-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/haskell/warp-web-app:latest`
  - 기본 포트: `4000`
  - 문서: `haskell/README.md`

- OCaml Dream Web App
  - 경로: `ocaml/dream_web_app/`
  - Dockerfile: `ocaml/dream_web_app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/ocaml/dream_web_app:latest`
  - 기본 포트: `4000`
  - 문서: `ocaml/README.md`

- SBCL Hunchentoot Web App
  - 경로: `sbcl/hunchentoot-web-app/`
  - Dockerfile: `sbcl/hunchentoot-web-app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/sbcl/hunchentoot-web-app:latest`
  - 기본 포트: 프로젝트 구현에 따름(예제는 소스에서 바인딩)
  - 문서: `sbcl/README.md`

- Elixir Phoenix Web App
  - 경로: `elixir/phx_web_app/`
  - Dockerfile: `elixir/phx_web_app/Dockerfile`
  - 이미지 태그(예시): `mingyuchoo/elixir/phx_web_app:latest`
  - 기본 포트: Phoenix 설정에 따름(일반적으로 4000)
  - 문서: `elixir/README.md`

- NixOS 기반 유틸리티 이미지
  - 경로: `nixos/`
  - Dockerfile: `nixos/<lang>/Dockerfile` (bun, elixir, go, haskell 등)
  - Docker Hub: [Docker Hub Repository](https://hub.docker.com/repository/docker/mingyuchoo/nixos)
  - 비고: 개발/도구 환경을 갖춘 베이스 이미지 샘플

## 빠른 시작(공통)

아래 명령은 리포지토리 루트가 아닌, 각 프로젝트 디렉터리에서 실행하는 것을 권장합니다.

### Windows PowerShell

```powershell
cls
$env:DOCKER_BUILDKIT = "1"
docker build . --tag <your-image:tag>
docker run --rm -p <host-port>:<container-port> <your-image:tag>
```

### Bash(macOS/Linux/WSL2)

```bash
export DOCKER_BUILDKIT=1
docker build . --tag <your-image:tag>
docker run --rm -p <host-port>:<container-port> <your-image:tag>
```

루트에서 빌드할 경우 `--file`과 컨텍스트 경로를 명시하세요.

```powershell
cls
$env:DOCKER_BUILDKIT = "1"
docker build --tag <your-image:tag> `
  --file .\<project-path>\Dockerfile .\<project-path>
```

## 빌드/런타임 최적화 가이드

- 멀티스테이지 빌드: 빌드 이미지와 런타임 이미지를 분리하여 크기를 최소화합니다.
- 패키지 복원 분리: `.csproj`/`package.json`/`requirements.txt` 등을 먼저 복사하고 복원하여 캐시 적중률을 높입니다.
- 캐시 마운트(BuildKit): `--mount=type=cache`를 활용해 의존성 복원 및 빌드 속도를 개선합니다. 예) `dotnet restore`, `cargo chef`.
- 슬림 런타임: `alpine`, `-slim` 기반 이미지를 사용해 배포 이미지를 경량화합니다.
- 불필요한 아티팩트 제거: 빌드 후 캐시/중간 산출물 제거로 이미지 크기를 줄입니다.
- 보안: 비루트 사용자로 실행, 필요 권한만 부여합니다(Rust/Haskell 예제 참조).

## 참고 링크

- `dotnet/csharp-web-app/README.md` — .NET 9 C# 앱 빌드/실행/디버깅
- `dotnet/fsharp-web-app/README.md` — .NET 9 F# 앱 빌드/실행
- `nodejs/express-web-app/README.md` — Node.js 23 Express 앱
- `python/fast-web-app/README.md` — FastAPI + Uvicorn 앱
- `rust/axum-web-app/README.md` — Rust Axum 앱
- `haskell/README.md` — Haskell 샘플
- `ocaml/README.md` — OCaml Dream 샘플
- `sbcl/README.md` — SBCL Hunchentoot 샘플
- `elixir/README.md` — Elixir/Phoenix 샘플
- `nixos/README.md` — NixOS 기반 유틸리티 이미지 안내

## 포트 요약

- 8080: `dotnet/csharp-web-app`, `dotnet/fsharp-web-app`
- 4000: `nodejs/express-web-app`, `python/fast-web-app`, `rust/axum-web-app`, `haskell/warp-web-app`, `ocaml/dream_web_app`
- Elixir Phoenix: 환경설정에 따름(일반적으로 4000)

## 라이선스

- 본 리포지토리의 라이선스는 상단 배지의 링크를 참고하세요.
