# syntax=docker/dockerfile:1.7

# 빌드 아규먼트: 러스트 버전, 타깃, 앱 이름
ARG RUST_VERSION=1.89.0
ARG TARGET=x86_64-unknown-linux-musl
ARG APP_NAME=axum-web-app

# 스테이지 1) 빌드 기반 이미지 (cargo-chef 포함 준비)
FROM rust:${RUST_VERSION}-alpine AS chef

# 이 스테이지에서 사용할 ARG 재선언
ARG TARGET

# 작업 디렉터리 설정
WORKDIR /usr/src/axum-web-app

# 빌드 도구/라이브러리 설치 및 cargo-chef 준비
RUN set -eux; \
    apk add --no-cache \
      musl-dev \
      openssl-dev \
      pkgconfig \
      build-base \
      binutils \
      git; \
    rustup target add ${TARGET}; \
    cargo install cargo-chef --locked

# 스테이지 2) 의존성 빌드 계획 생성 (레이어 캐시 최적화)
FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# 스테이지 3) 의존성 컴파일 (BuildKit 캐시 마운트 사용)
FROM chef AS builder

# 이 스테이지에서 사용할 ARG 재선언
ARG TARGET
ARG APP_NAME
COPY --from=planner /usr/src/axum-web-app/recipe.json ./
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/src/axum-web-app/target \
    cargo chef cook --release --target ${TARGET} --recipe-path recipe.json

# 애플리케이션 소스 복사 및 빌드 (캐시 마운트 + 바이너리 스트립)
COPY . .
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/src/axum-web-app/target \
    cargo build --release --target ${TARGET} && \
    strip target/${TARGET}/release/${APP_NAME} && \
    mkdir -p /usr/src/axum-web-app/bin && \
    cp target/${TARGET}/release/${APP_NAME} /usr/src/axum-web-app/bin/${APP_NAME}

# 스테이지 4) 런타임 최소 이미지
FROM alpine:3.20 AS runtime

ARG TARGET=x86_64-unknown-linux-musl
ARG APP_NAME=axum-web-app

# 보안 강화를 위한 비루트 사용자 생성
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 실행 디렉터리
WORKDIR /usr/local/bin

# 빌드 결과 바이너리만 복사 (캐시 마운트 외부 경로)
COPY --from=builder /usr/src/axum-web-app/bin/${APP_NAME} /usr/local/bin/${APP_NAME}

# 권한 설정
RUN chmod +x /usr/local/bin/${APP_NAME} && chown appuser:appgroup /usr/local/bin/${APP_NAME}

# 실행 환경 변수
ENV APP_PORT=4000 \
    TZ=Asia/Seoul

# 타임존 설정 (tzdata만 설치)
RUN apk add --no-cache tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 비루트 사용자로 실행
USER appuser

# 포트 노출 (ENV 확장 대신 고정 포트 명시)
EXPOSE 4000

# 실행 커맨드
CMD ["/usr/local/bin/axum-web-app"]
