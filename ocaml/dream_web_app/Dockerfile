# First stage: Build stage
FROM ocaml/opam:ubuntu-24.10-ocaml-5.3 AS builder

# Set the working directory
WORKDIR $HOME/dream_web_app

# Install necessary system packages
RUN sudo apt-get update && \
    sudo apt-get install -y pkg-config libgmp-dev libev-dev libssl-dev

# Copy the application source code to the container
COPY . .

RUN sudo chown -R opam:opam $HOME/dream_web_app

# Install dependencies and build the application
USER opam

# Install dependencies and build the application
#RUN opam update
RUN opam install -y dune dream

RUN eval $(opam env)

RUN opam install --deps-only --yes .
RUN opam exec -- dune build --release

# Second stage: Run stage
FROM ubuntu:24.10

# Set the working directory for the final stage
WORKDIR $HOME/bin

# Install dependencies and build the application
USER opam

# Copy the built application from the builder stage
COPY --from=builder $HOME/dream_web_app/_build/default/bin/main.exe .

# Set the ownership to the non-root user
RUN sudo chown -R opam:opam $HOME/bin

# Expose the necessary port (replace <port> with the actual port number)
EXPOSE 8080

# Command to run the application
CMD ["./main.exe"]