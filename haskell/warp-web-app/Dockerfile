#######################################
# Build Stage
#######################################
FROM haskell:9.8.4-slim as builder

ENV CABAL_JOBS=4

WORKDIR /app

# Install dependencies
COPY warp-web-app.cabal .
RUN cabal update
RUN cabal build --only-dependencies

# Copy and build source code
COPY . .
RUN cabal install --installdir=/app/install

#######################################
# Run Stage
#######################################
FROM haskell:9.8.4-slim

WORKDIR /app

# Copy binary and static files
COPY --from=builder /app/install/warp-web-app.exe /app/warp-web-app.exe
COPY --from=builder /app/index.html /app/index.html

# Create a user to run the application
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

EXPOSE 3000

# Run the application binary
CMD ["/app/warp-web-app.exe"]
