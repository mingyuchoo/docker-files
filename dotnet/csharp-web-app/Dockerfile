# syntax=docker/dockerfile:1.6
# 단계 1: 애플리케이션 빌드
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS restore
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
WORKDIR /src

# 프로젝트 파일만 먼저 복사하여 복원 레이어 캐시율을 극대화
COPY csharp-web-app.csproj ./
RUN --mount=type=cache,target=/root/.nuget/packages \
    dotnet restore csharp-web-app.csproj --nologo

# Build 단계: 소스 전체 복사 후 publish만 수행
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
WORKDIR /src
COPY . .
RUN --mount=type=cache,target=/root/.nuget/packages \
    dotnet restore csharp-web-app.csproj --nologo
RUN --mount=type=cache,target=/root/.nuget/packages \
    dotnet publish csharp-web-app.csproj -c Release -o /app \
    --no-restore --nologo \
    -p:UseAppHost=false

# Runtime 단계: 슬림 런타임 이미지 사용
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS runtime
WORKDIR /app
ENV ASPNETCORE_URLS=http://0.0.0.0:8080 \
    DOTNET_EnableDiagnostics=0

# 빌드 결과만 복사
COPY --from=build /app .

# 서비스 포트 공개
EXPOSE 8080

# 실행 엔트리포인트
ENTRYPOINT ["dotnet", "csharp-web-app.dll"]
