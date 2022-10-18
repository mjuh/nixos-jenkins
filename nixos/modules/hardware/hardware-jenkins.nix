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
    services.cloud-init.enable = true;
    systemd.services."serial-getty@ttyS0".enable = true;

    system.build.kubevirtImage = import (modulesPath + "/../lib/make-disk-image.nix") {
      inherit lib config pkgs;
      format = "qcow2";
    };
  };
}
