{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let callPackage = lib.callPackageWith haskell.packages.ghc984;
in callPackage ./nix-app.nix { inherit stdenv; }
