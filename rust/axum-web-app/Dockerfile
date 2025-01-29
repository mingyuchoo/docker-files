# Use a specific Rust version and Alpine base image
FROM rust:1.84.0-alpine AS chef

# Set the working directory
WORKDIR /usr/src/axum-web-app

# Install dependencies and tools
RUN set -eux; \
    apk add --no-cache musl-dev openssl-dev; \
    rustup target add x86_64-unknown-linux-musl; \
    cargo install cargo-chef --locked; \
    rm -rf $CARGO_HOME/registry

# Prepare the build plan
FROM chef AS planner

COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Build the application
FROM chef AS builder

COPY --from=planner /usr/src/axum-web-app/recipe.json ./
RUN cargo chef cook --release --target x86_64-unknown-linux-musl --recipe-path recipe.json

COPY . .
RUN cargo build --release --target x86_64-unknown-linux-musl

# Final stage: Create a minimal image with the built application
FROM alpine:latest

# Create a user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory
WORKDIR /usr/local/bin

# Copy the built binary from the builder stage
COPY --from=builder /usr/src/axum-web-app/target/x86_64-unknown-linux-musl/release/axum-web-app ./

# Ensure the binary is executable
RUN chmod +x axum-web-app && chown appuser:appgroup axum-web-app

# Set environment variables
ENV APP_PORT=4000
ENV TZ=Asia/Seoul

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Switch to the user
USER appuser

# Expose the application port
EXPOSE $APP_PORT

# Run the application
CMD ["./axum-web-app"]
