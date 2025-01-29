# Arguments to the derivation.
{ mkDerivation, aeson, base, hpack, servant-server, stdenv, warp }:

# The output.
mkDerivation {
  pname = "nix-app";
  version = "0.1.0.0";
  src = ./.;
  isExecutable = true;
  executableHaskellDepends = [ aeson base servant-server warp ];
  executableToolDepends = [ hpack ];
  preConfigure = "hpack";
  license = "Mingyu Choo";
}
