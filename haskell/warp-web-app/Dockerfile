# Stage 1: Build the application
FROM haskell:9.12.2-slim AS builder

ENV CABAL_JOBS=4
ARG APP_NAME=warp-web-app

# Set the working directory
WORKDIR /usr/src/warp-web-app

# 1) 의존성 복원 레이어 (캐시 최적화)
#    소스 코드를 복사하기 전에 cabal 파일만 복사하여 의존성만 먼저 빌드합니다.
COPY warp-web-app.cabal ./
RUN cabal update && \
    cabal build --only-dependencies

# 2) 애플리케이션 빌드 (아티팩트 최소화)
#    전체 소스를 복사한 뒤, 실행 파일만 설치 디렉터리에 복사하며 스트립/문서 비활성화로 크기를 최소화합니다.
COPY . .
RUN cabal install \
      --installdir=/usr/local/bin \
      --install-method=copy \
      --overwrite-policy=always \
      --enable-executable-stripping \
      --disable-documentation \
      all

# Stage 2: Create the minimal image
#FROM haskell:9.12.2-slim
FROM debian:bookworm-slim

# Set environment variables
ENV APP_PORT=4000
ENV TZ=Asia/Seoul

# Set the timezone
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      tzdata \
      libgmp10; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; echo $TZ > /etc/timezone; \
    apt-get clean; rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy executable and necessary files
COPY --from=builder --chown=65532:65532 /usr/local/bin/warp-web-app /app/warp-web-app
COPY --from=builder --chown=65532:65532 /usr/src/warp-web-app/index.html /app/index.html

# Create a user to run the application
RUN set -eux; \
    groupadd -g 65532 -r appuser; \
    useradd -u 65532 -r -g appuser appuser

# Ensure the binary is executable
# (권한/소유권은 COPY --chown 으로 처리되어 별도 단계 불필요)

# Switch to the user
USER appuser

# Expose the application port
EXPOSE $APP_PORT

# Run the application
CMD ["./warp-web-app"]
