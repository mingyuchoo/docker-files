# syntax=docker/dockerfile:1.7
# 공식 Elixir 이미지(otp-28) 다이제스트 핀 고정
# 참고: https://hub.docker.com/layers/library/elixir/otp-28/images/sha256-5c9d545621b5f36900a445dfa9f00c0a7f66c22ed96dad66aa7a399e6ce5c4ca
ARG BUILDER_IMAGE="elixir:otp-28@sha256:5c9d545621b5f36900a445dfa9f00c0a7f66c22ed96dad66aa7a399e6ce5c4ca"
ARG RUNNER_DEBIAN=bookworm-slim
ARG RUNNER_IMAGE="debian:${RUNNER_DEBIAN}"

FROM ${BUILDER_IMAGE} AS builder

# build 툴 설치 (BuildKit 캐시 활용)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends build-essential git && \
    rm -rf /var/lib/apt/lists/*

# prepare build dir
WORKDIR /app

# mix/hex 캐시 경로 설정 및 설치 (캐시 활용)
ENV MIX_HOME=/root/.mix \
    HEX_HOME=/root/.hex
# 중요: Hex/Rebar는 이미지 레이어에 영속되도록 캐시 마운트 없이 설치
RUN mix local.hex --force && mix local.rebar --force

# build 환경 설정
ENV MIX_ENV="prod"

# 의존성 복원 (소스 분리로 캐시 최대화)
COPY mix.exs mix.lock ./
RUN --mount=type=cache,target=/root/.hex,sharing=locked \
    --mount=type=cache,target=/root/.mix,sharing=locked \
    --mount=type=cache,target=/app/deps,sharing=locked \
    --mount=type=cache,target=/app/_build,sharing=locked \
    mix deps.get --only $MIX_ENV
# 에셋 빌드 도구(dev 전용) 확보를 위해 dev 의존성도 가져오기
RUN --mount=type=cache,target=/root/.hex,sharing=locked \
    --mount=type=cache,target=/root/.mix,sharing=locked \
    --mount=type=cache,target=/app/deps,sharing=locked \
    --mount=type=cache,target=/app/_build,sharing=locked \
    mix deps.get --only dev
RUN mkdir -p config

# 컴파일 타임 설정 선복사: deps 재컴파일 트리거를 정확히 하여 캐시 최적화
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN --mount=type=cache,target=/root/.hex,sharing=locked \
    --mount=type=cache,target=/root/.mix,sharing=locked \
    --mount=type=cache,target=/app/deps,sharing=locked \
    --mount=type=cache,target=/app/_build,sharing=locked \
    mix deps.compile

COPY priv priv

COPY lib lib

COPY assets assets

# 정적 자산 빌드 (필요 시 esbuild/ Tailwind 캐시 사용 가능)
RUN --mount=type=cache,target=/app/deps,sharing=locked \
    --mount=type=cache,target=/app/_build,sharing=locked \
    mix assets.deploy

# 소스 컴파일
RUN --mount=type=cache,target=/app/deps,sharing=locked \
    --mount=type=cache,target=/app/_build,sharing=locked \
    mix compile

# runtime 설정은 재컴파일 불필요
COPY config/runtime.exs config/

# 릴리즈 생성 (아티팩트만 남김)
RUN --mount=type=cache,target=/app/_build,sharing=locked \
    mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

# 런타임에 필요한 최소 라이브러리만 설치 (no-recommends, 캐시 활용)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends libstdc++6 libssl3 libncurses6 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 로케일 설치 제거로 이미지 슬림화 (필요 시 상단에만 활성화)

WORKDIR "/app"
RUN chown nobody /app

# 런타임 환경 설정
ENV MIX_ENV="prod" \
    PHX_SERVER=true

# 빌더 단계의 릴리즈 산출물만 복사 (권한 포함)
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/phx_web_app ./

USER nobody

CMD ["/app/bin/phx_web_app", "foreground"]