{
  description = "";

  nixConfig = {
    substituters = [ "https://cache.nixos.intr/" ];
    trustedPublicKeys = [ "cache.nixos.intr:6VD7bofl5zZFTEwsIDsUypprsgl7r9I+7OGY4WsubFA=" ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs, deploy-rs, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell = with nixpkgs.legacyPackages."${system}"; mkShell {
        buildInputs = [
          nixFlakes
          deploy-rs.outputs.packages.${system}.deploy-rs
        ];
        shellHook = ''
          . ${nixFlakes}/share/bash-completion/completions/nix
          export LANG=C
        '';
      };
    })
    // (let
      system = "x86_64-linux";
    in
      {
      });
}
