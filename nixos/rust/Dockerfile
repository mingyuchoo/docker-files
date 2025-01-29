FROM nixos/nix:latest

RUN nix-channel --update
RUN nix-env --install --attr \
    nixpkgs.curl \
    nixpkgs.tree \
    nixpkgs.vim \
    nixpkgs.rustup \
    nixpkgs.gcc

RUN rustup toolchain install stable
RUN rustup default stable
