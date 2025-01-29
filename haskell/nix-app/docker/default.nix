{ pkgs ? import <nixpkgs> {} }:

let myApp = import ../../nix-app { inherit pkgs; };
in

with pkgs;

dockerTools.buildImage {
  name = "nix-app";
  contents = [ myApp ];

  config = {
    Cmd = [ "${myApp}/bin/nix-app.exe" ];
    ExposedPorts = {
      "8000/tcp" = {};
    };
  };
}
