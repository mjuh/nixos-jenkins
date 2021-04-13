{ config, pkgs, options, ... }:

{
  # Place here any custom configuration specific to your organisation (locale, ...)
  services.openssh.permitRootLogin = "yes";
  time.timeZone = "Europe/Moscow";
  networking.hostName = "nixos.intr"; # Define your hostname.
  networking.firewall.enable = false;
  networking.interfaces.enp1s0f0.ipv4.addresses = [{
    address = "172.16.103.238";
    prefixLength = 24;
  }];
  networking.defaultGateway = "172.16.103.1";
  networking.nameservers = [ "172.16.103.2" "172.16.102.2" "8.8.8.8" ];
  # Define a user account. Don't forget to set a password with ‘passwd’.

  #   users.users.vmxxxx = {
  #     isNormalUser = true;
  #     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   };

  users.users.eng = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # Created automatically by nixos/modules/services/continuous-integration/gitlab-runner.nix
  # users.users.gitlab-runner = {
  #   isNormalUser = true;
  # };

  nixpkgs.config.packageOverrides = pkgs: rec {
    addsshnode = pkgs.callPackage ./ci/jenkins/add-ssh-node { };
    genjenkplugins = pkgs.callPackage ./ci/jenkins/gen-jenk-plugins { };
    jenkins-jcasc-config = pkgs.callPackage ./ci/jenkins/JCasC { };
    jenkins-jobs-config = pkgs.callPackage ./ci/jenkins/jenkins-jobs-config { };
    # TODO: Add "androidemu = pkgs.callPackage ./ci/jenkins/androidemu {};" in custom-configuration.nix file.
    jdk = pkgs.jdk8.override {
        cacert = pkgs.runCommand "mycacert" {} ''
        mkdir -p $out/etc/ssl/certs
        cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
          ${./ci/jenkins/cert/nexus.crt} > $out/etc/ssl/certs/ca-bundle.crt
        '';
         };
    cached-nix-shell = pkgs.callPackage  (fetchGit {url = "https://github.com/xzfc/cached-nix-shell"; ref = "master";}).outPath {};
  };

### overlays
#    nixpkgs.overlays = [ (import (builtins.fetchGit {url = "https://gitlab.intr/_ci/nixpkgs"; ref = "mytest";}) ) ];
#    nix.nixPath =
#      # Prepend default nixPath values.
#      options.nix.nixPath.default ++ 
#      # Append our nixpkgs-overlays.
#      [ "nixpkgs-overlays=/etc/nixos/overlays-compat" ];

}
