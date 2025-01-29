FROM nixos/nix:latest

RUN nix-channel --update
RUN nix-env --install --attr \
    nixpkgs.curl \
    nixpkgs.tree \
    nixpkgs.vim \
    nixpkgs.llvm_19 \
    nixpkgs.llvmPackages_19
