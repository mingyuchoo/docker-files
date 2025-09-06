# fsharp-web-app

## Quick Start

- 이 프로젝트는 .NET 9 기반 C# 웹 애플리케이션입니다.
- Dockerfile은 `dotnet/fsharp-web-app/`에 위치합니다.

---

## PowerShell 사용법 (Windows)

### 1) .NET 로컬 빌드/실행

```powershell
cls
dotnet build
dotnet run
```

### 2) Docker 이미지 빌드

빌드킷(BuildKit)을 활성화하면 캐시 마운트를 활용해 재빌드 속도가 빨라집니다.

- 앱 디렉터리(`dotnet/fsharp-web-app/`)에서 빌드하는 방법

```powershell
cls
$env:DOCKER_BUILDKIT = "1"
docker build . --tag mingyuchoo/dotnet/fsharp_web_app:latest
```

- 리포지토리 루트에서 Dockerfile과 컨텍스트를 명시하여 빌드하는 방법

```powershell
cls
$env:DOCKER_BUILDKIT = "1"
docker build --tag mingyuchoo/dotnet/fsharp_web_app:latest `
  --file .\dotnet\fsharp-web-app\Dockerfile .\dotnet\fsharp-web-app
```

- PowerShell 인자 파싱 이슈가 있을 경우, `--%`를 사용하여 인자를 그대로 전달하세요.

```powershell
cls
$env:DOCKER_BUILDKIT = "1"
docker --% build --tag mingyuchoo/dotnet/fsharp_web_app:latest --file dotnet/fsharp-web-app/Dockerfile dotnet/fsharp-web-app
```

### 3) 컨테이너 실행

```powershell
docker run --rm -p 8080:8080 mingyuchoo/dotnet/fsharp_web_app:latest
# or (detached)
docker run -d -p 8080:8080 mingyuchoo/dotnet/fsharp_web_app:latest
```

### 4) 디버깅

Alpine 기반 런타임은 `bash`가 없을 수 있으므로 `/bin/sh` 사용을 권장합니다.

```powershell
docker image ls --all
docker run -it --entrypoint /bin/sh mingyuchoo/dotnet/fsharp_web_app:latest
```

---

## Bash 사용법 (macOS/Linux/WSL2)

### Bash: .NET 로컬 빌드/실행

```bash
dotnet build
dotnet run
```

### Bash: Docker 이미지 빌드

- 앱 디렉터리(`dotnet/fsharp-web-app/`)에서 빌드

```bash
export DOCKER_BUILDKIT=1
docker build . --tag mingyuchoo/dotnet/fsharp_web_app:latest
```

- 리포지토리 루트에서 Dockerfile/컨텍스트 명시 빌드

```bash
export DOCKER_BUILDKIT=1
docker build --tag mingyuchoo/dotnet/fsharp_web_app:latest \
  --file ./dotnet/fsharp-web-app/Dockerfile ./dotnet/fsharp-web-app
```

### Bash: 컨테이너 실행

```bash
docker run --rm -p 8080:8080 mingyuchoo/dotnet/fsharp_web_app:latest
# or (detached)
docker run -d -p 8080:8080 mingyuchoo/dotnet/fsharp_web_app:latest
```

### Bash: 디버깅

```bash
docker image ls --all
docker run -it --entrypoint /bin/sh mingyuchoo/dotnet/fsharp_web_app:latest
```

---

## How to access this service from web browser

- `http://localhost:8080`
