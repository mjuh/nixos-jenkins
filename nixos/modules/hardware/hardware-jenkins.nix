# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

# This module almost a copy of
# github.com/NixOS/nixpkgs/nixos/modules/virtualisation/kubevirt.nix

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
    };

    boot.growPartition = true;
    boot.kernelParams = [ "console=ttyS0" ];
    boot.loader.grub.device = "/dev/vda";
    boot.loader.timeout = 0;

    services.qemuGuest.enable = true;
    services.openssh.enable = true;
    systemd.services."serial-getty@ttyS0".enable = true;

    system.build.kubevirtImage = import (modulesPath + "/../lib/make-disk-image.nix") {
      inherit lib config pkgs;
      format = "qcow2";
    };
    services.cloud-init.enable = lib.mkForce false;

    fileSystems."/var/run/secrets/kubernetes.io/serviceaccount" = {
      device = "/dev/disk/by-label/cfgdata";
      fsType = "iso9660";
      options = [
        "ro"
        "uid=${builtins.toString config.users.users.jenkins.uid}"
        "gid=${builtins.toString config.users.groups.jenkins.gid}"
      ];
    };
  };
}
