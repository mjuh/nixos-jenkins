self: super:
with super.lib;
let
config.nixpkgs.overlays = [ (import (builtins.fetchGit {url = "https://gitlab.intr/_ci/nixpkgs"; ref = "mytest";}) ) ];

  #config.nixpkgs.overlays = import /tmp/nixpkgs/overlay ;
  # Using the nixos plumbing that's used to evaluate the config...
  eval = import <nixpkgs/nixos/lib/eval-config.nix>;
  # Evaluate the config,
  paths = (eval {modules = [(import <nixos-config>)];})
    # then get the `nixpkgs.overlays` option.
    .config.nixpkgs.overlays
  ;
in
foldl' (flip extends) (_: super) paths self
