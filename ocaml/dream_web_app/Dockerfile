# First stage: Build stage
FROM ocaml/opam:ubuntu-24.10-ocaml-5.3 AS builder

# Set the working directory
WORKDIR /usr/src/dream_web_app

# Install necessary system packages
RUN sudo apt-get update && \
    sudo apt-get install -y pkg-config libgmp-dev libev-dev libssl-dev

# Copy the application source code to the container
COPY . .

# Install dependencies and build the application
RUN opam update
RUN opam install -y ocaml dune dream
RUN opam install --deps-only --yes .
RUN $HOME/.opam/default/bin/dune build --release

# Second stage: Run stage
FROM ubuntu:24.10

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Set the working directory for the final stage
WORKDIR /usr/local/bin

# Copy the built application from the builder stage
COPY --from=builder /usr/src/dream_web_app/_build/default/bin/dream_web_app .

# Set the ownership to the non-root user
RUN chown appuser:appuser /usr/local/bin/dream_web_app

# Switch to the non-root user
USER appuser

# Expose the necessary port (replace <port> with the actual port number)
EXPOSE 8080

# Command to run the application
CMD ["./dream_web_app"]