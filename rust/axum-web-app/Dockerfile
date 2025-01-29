#######################################
# Build Stage
#######################################
FROM rust:latest as builder

WORKDIR /usr/src/app

COPY Cargo.toml Cargo.lock ./

RUN cargo build --release --target x86_64-unknown-linux-musl

COPY src ./src

#######################################
# Run Stage
#######################################
RUN cargo build --release --target x86_64-unknown-linux-musl

FROM alpine:latest

ENV APP_PORT=3000

RUN apk update && apk add ca-certificates tzdata

COPY --from=builder /usr/src/app/target/x86_64-unknown-linux-musl/release/axum-web-app /usr/local/bin/axum-web-app

RUN chmod +x /usr/local/bin/axum-web-app

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["/usr/local/bin/axum-web-app"]

EXPOSE 3000