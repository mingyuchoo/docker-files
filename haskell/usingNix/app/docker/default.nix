{ pkgs ? import <nixpkgs> {} }:

let app = import ../../app { inherit pkgs; };
in

with pkgs;

dockerTools.buildImage {
  name = "app";
  contents = [ app ];

  config = {
    Cmd = [ "${app}/bin/app-exe" ];
    ExposedPorts = {
      "8000/tcp" = {};
    };
  };
}
