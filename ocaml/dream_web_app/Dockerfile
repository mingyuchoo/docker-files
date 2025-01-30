# First stage: Build stage
FROM ocaml/opam:ubuntu-24.10-ocaml-5.3 AS builder

ENV HOME=/home/opam

# Set the working directory
WORKDIR $HOME/dream_web_app

# Install necessary system packages
RUN sudo apt-get update && \
    sudo apt-get install -y pkg-config libgmp-dev libev-dev libssl-dev && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

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

ENV HOME=/home/opam

# Set the working directory for the final stage
WORKDIR /app

# Install necessary runtime dependencies
RUN apt-get update && \
    apt-get install -y libev4 libssl3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the built application from the builder stage
COPY --from=builder $HOME/dream_web_app/_build/default/bin/main.exe .

# Expose the necessary port (replace <port> with the actual port number)
EXPOSE 4000

# Command to run the application
CMD ["./main.exe"]