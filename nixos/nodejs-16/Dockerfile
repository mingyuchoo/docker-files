FROM nixos/nix

RUN nix-channel --update
RUN nix-env --install --attr \
    nixpkgs.curl \
    nixpkgs.tree \
    nixpkgs.vim \
    nixpkgs.nodejs-16_x \
    nixpkgs.yarn
