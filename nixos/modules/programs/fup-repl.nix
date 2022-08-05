{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.fup-repl;
in {
  options.programs.fup-repl = {
    package = mkOption {
      type = types.package;
      default = pkgs.fup-repl;
      defaultText = "pkgs.fup-repl";
      description = ''
        The fup-repl package that should be used.
      '';
    };
    enable = mkEnableOption "Nix repl wrapper which loads everything in a top scope";
    flake = mkOption {
      type = types.attrs;
      default = {
        nix = ../../../etc/nixos/flake.nix;
        lock = ../../../etc/nixos/flake.lock;
      };
      description = ''
        flake.nix and flake.nix which will be coppied to /etc/nixos
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
    environment.etc."nixos/flake.nix".text = builtins.readFile cfg.flake.nix;
    environment.etc."nixos/flake.lock".text = builtins.readFile cfg.flake.lock;
  };
}
