{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let callPackage = lib.callPackageWith haskell.packages.ghc884;
in callPackage ./app.nix { inherit stdenv; }
