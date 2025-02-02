# Stage 1: Build the application
FROM haskell:9.8.4-slim AS builder

ENV CABAL_JOBS=4

# Set the working directory
WORKDIR /usr/src/warp-web-app

# Install dependencies
COPY warp-web-app.cabal .
RUN cabal update && \
    cabal build --only-dependencies

# Copy and build source code
COPY . .
RUN cabal install --installdir=/usr/src/warp-web-app/install

# Stage 2: Create the minimal image
#FROM haskell:9.8.4-slim
FROM debian:bookworm-slim

# Set environment variables
ENV APP_PORT=4000
ENV TZ=Asia/Seoul

# Set the timezone
RUN apt-get update && apt-get install -y tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy executable and necessary files
COPY --from=builder /usr/src/warp-web-app/install/warp-web-app ./warp-web-app
COPY --from=builder /usr/src/warp-web-app/index.html ./index.html

# Create a user to run the application
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Ensure the binary is executable
RUN chmod +x warp-web-app && chown appuser:appuser warp-web-app

# Switch to the user
USER appuser

# Expose the application port
EXPOSE $APP_PORT

# Run the application
CMD ["./warp-web-app"]
