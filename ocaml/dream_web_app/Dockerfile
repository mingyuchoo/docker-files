# 스테이지 1) Build stage
FROM ocaml/opam:ubuntu-24.10-ocaml-5.3 AS builder

ENV HOME=/home/opam

# Set the working directory
WORKDIR $HOME/dream_web_app

# System packages (root 권한으로 최소 설치)
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends pkg-config libgmp-dev libev-dev libssl-dev ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 의존성 캐시 극대화를 위한 메타파일만 우선 복사
USER opam
COPY --chown=opam:opam dream_web_app.opam dune-project ./

# Dependencies restore (dune 먼저, 그 다음 프로젝트 deps)
RUN opam update && \
    opam install -y dune && \
    opam install --deps-only --yes .

# 나머지 소스 복사 후 빌드
COPY --chown=opam:opam . .
RUN opam exec -- dune build --release

# 스테이지 2) Run stage
FROM debian:stable-slim

# Set the working directory for the final stage
WORKDIR /app

# Install necessary runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends libev4 libssl3 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 비루트 사용자 생성 및 권한 설정
RUN groupadd -r app && useradd -r -g app app

# Copy the built application from the builder stage
COPY --from=builder /home/opam/dream_web_app/_build/default/bin/main.exe /app/main.exe
RUN chown app:app /app/main.exe

# Expose the necessary port (replace <port> with the actual port number)
EXPOSE 4000

# Command to run the application
USER app
CMD ["/app/main.exe"]