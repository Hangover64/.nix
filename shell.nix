# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Automatically set the dynamic linker.
  NIX_LD_LIBRARY_PATH = "${pkgs.openssl.lib}/lib:${pkgs.zlib.lib}/lib";
  NIX_LD = "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
}

