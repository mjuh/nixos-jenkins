{ config, lib, pkgs, ... }:

{
  boot = {
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.device = "/dev/vda";

    # remove the fsck that runs at startup. It will always fail to run, stopping
    # your boot until you press *.
    initrd.checkJournalingFS = false;
  };

  networking = {
    hostName = "vmhost";
    firewall.enable = false;
  };

  virtualisation = {
    cores = 2;
    diskSize = 512 * 10;
    memorySize = 1024 * 4;
  };

  users.extraUsers.vm = {
    password = "vm";
    shell = "${pkgs.bash}/bin/bash";
    group = "wheel";
    isNormalUser = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Only for testing
  #
  system.activationScripts.vault-secrets = with pkgs;
    let
      script = writeScript "vault-secrets.sh" ''
        #!${runtimeShell}
        export PATH=${coreutils}/bin:$PATH
        mkdir /root/vault-secrets.env.d
        for file in jenkins.intr
        do
            cat > /root/vault-secrets.env.d/"$file" <<'EOF'
        VAULT_ROLE_ID=
        VAULT_SECRET_ID=
        EOF
        done
      '';
    in "${script}";

  services = {
    # Automatically log in at the virtual consoles.
    mingetty.autologinUser = "root";

    openssh = {
      enable = true;
      # Allow password login to the installation, if the user sets a password via "passwd"
      # It is safe as root doesn't have a password by default and SSH is disabled by default
      permitRootLogin = "yes";
    };

    ci = {
      enable = true;
      gitlabGroups = [{ name = "jenkins-test"; }];
    };

    # Override CASC_JENKINS_CONFIG
    #
    # jenkins.environment.CASC_JENKINS_CONFIG = with builtins;
    #   lib.mkForce (toString (pkgs.writeText "jenkins.yml" (builtins.toJSON
    #     ((import ../jcasc.nix { inherit pkgs; }) // {
    #       jobs = [{ file = ../jobs.groovy; }];
    #     }))));

    # XXX: Could we use gitlab instance in hosts/vm.nix for testing?

    # postgresql = {
    #   enable = true;
    #   package = pkgs.postgresql_12;
    # };

    # Testing instance
    # gitlab = rec {
    #   enable = true;
    #   initialRootPasswordFile =
    #     builtins.toFile "gitlab-initial-root-password-file"
    #       "ainuaBi4shoodae3";
    #   secrets = {
    #     secretFile = initialRootPasswordFile;
    #     dbFile = initialRootPasswordFile;
    #     otpFile = initialRootPasswordFile;
    #     jwsFile = builtins.toFile "gitlab-jws-file" ''
    #       -----BEGIN RSA PRIVATE KEY-----
    #       MIIEpAIBAAKCAQEAv537a6GivlQus+UgJsqmBV4BVno80gQN7KJUsDRrC6UEwKmq
    #       bvqY/DRHxsKqh/1HUVvTGR3uMU7+x5TkaNjkg04zX3GsOrbfLPeY3mu9aENDIgEl
    #       u6QeW1QgyKoEuUBDqG5rhyG6SbFrc2tECSSXvX79L64FOFB63BihsshoDfcRW3Fe
    #       GrTxdzBBdnktFHfhvmbJivREyFZPnsiw8/iUbKqvvhJco26g+LQVVxTx9k/L6Chi
    #       lfC0NOCj3341BkMzNgipGLstYlHzOR2TCMluqMfH3L1XQhFRwid3m679EqxpODbz
    #       f1Bk/6FiEyuzMTxgoVPboHMvREsetscntZQqBQIDAQABAoIBACYIZW7nljXQ37Q1
    #       Njx83JcUIY/Yk1ncFCdz0PtobBbTmi3jf0Cn3NWySszYtqBnVVCAuVWy6yQ+WbOj
    #       ifKFmlW1n9zB4z2ELqfuPRloqR+Yuip1r9eeq6fU+uzZUjay2rsDr7QSrbcS0BEI
    #       qWhnKvchzX85OzACSWCGQxIJVR3wJCgYWUk6idU2mCGVLXPzffqnTbUIAM9AAUxc
    #       /9O+QB9DgahpA3uQrBGRBKmxisi/kx6HhIqCB7Pl51WPna8YNCwQ++przefsdz1L
    #       oCWGbhaeM2EaU8R99p93C97HGZYi+WOwyiTtQOiEusCBUGNpzwqTblbG9CYEkssZ
    #       FltAScECgYEA6Sb93sbO4ugkJfHSk+R3/51aXkU9m0gXIdUOOQKQTr0Z80ulMfqM
    #       6nlhrl0+Q4HBoH8i5pV5vQLmOo8UE5pGABLr3lZ0GbQVb6aN7BuAeWX+89EDkwE4
    #       1kuzeF30kqJSLdCX6L1pfZWcLPJf3oJwCpUkxTr/Vjvym+Av7XBRDVsCgYEA0mUD
    #       DpGKXZluFqJNgWRAZXjMBLFKitCGpYPbmzH/BnF2RI6OT2kxiv/Z/onu1t9paNmK
    #       Tf0vwi2d7fgcSmHMA4F51yE4banwVCXevPIxlejNCjgrV/Tsux6lhoa4/dvLmWx1
    #       hSJs7enAf6cDjCqpVfYX7PIZ5Bz01aiy6KFkZB8CgYEAyWlksJngSYavC5R/DEG3
    #       JDujwIJiOQ2q5hAurDM5xLt5eoLjn2xJZZkcOEvWqOyj/2k1FisUsqKZjwbhGhoQ
    #       1KmD11uqCjZWulAQlGIhtz3UZH4wb0MD/aQB0z6fNDlDcs6bHHTcd5/R/cYX6ZmW
    #       /p1e2X8g6zb4W43s+VoourcCgYBvEuLtQwrgZUsIagEvCWUx7PcQlyS6amJbaWR7
    #       54YyuZ3tjbE13VxJfM9yoRFVoTb+IrLwf3VCN2EELBOLdVwGkcloOOKYiroVQrT3
    #       3YkuEmyFM6g2VFjSZNiQT/nEE9DGG8tjUQxfAiQdgGfQDQm/FyAEeMAQfPUJA3oI
    #       dIQSkwKBgQCvXM7NeT6E/Ycs3xOTX5mQcV22njb4k6qzssdJ1hJmL0Ku7WxkTz4t
    #       N3rV03VKB1LuZ+nJlEEod83WknGYWg2PEx2ZdaPpE/uh/fL2xiWUgnCbEq5J4c58
    #       iy1QmAo3xJPRpcQq9d4cLM42ePKVbIfTLWqsQfJev30m/8AAotwzug==
    #       -----END RSA PRIVATE KEY-----
    #     '';
    #   };
    # };

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
}
