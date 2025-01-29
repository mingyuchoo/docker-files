#######################################
# Build Stage
#######################################
FROM --platform=linux/x86_64 rust:latest as builder

WORKDIR /app

COPY Cargo.toml Cargo.lock ./

COPY src ./src

RUN rustup target add x86_64-unknown-linux-musl

RUN cargo build --release --target x86_64-unknown-linux-musl


#######################################
# Run Stage
#######################################
FROM --platform=linux/x86_64 alpine:latest

WORKDIR /app

ENV APP_PORT=3000

RUN apk update && apk add ca-certificates tzdata

COPY --from=builder target/x86_64-unknown-linux-musl/release/axum-web-app /app/axum-web-app

RUN chmod +x /app/axum-web-app

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["/app/axum-web-app"]

EXPOSE 3000

