{ config, pkgs, ... }:

{

  fileSystems."/".label = "vmdisk";

  networking = {
    hostName = "vmhost";
    firewall.enable = false;
  };

  users.extraUsers.vm = {
    password = "vm";
    shell = "${pkgs.bash}/bin/bash";
    group = "wheel";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  imports = [
    ./services/admin.nix
    ./services/jenkins.nix
  ];

  services = {
    nginx = {
      virtualHosts = {
        "jenkins.intr" = {
          addSSL = pkgs.lib.mkForce false;
          sslCertificate = "";
          sslCertificateKey = "";
        };
      };
    };
  };

  virtualisation = {
    graphics = false; # Open serial console instead of graphical window.
    memorySize = 4096;
    diskSize = 1024 * 16;
    qemu = {
      networkingOptions =
        [ "-net nic,model=virtio" "-net user,hostfwd=tcp::2222-:22" ];
    };
  };
}
