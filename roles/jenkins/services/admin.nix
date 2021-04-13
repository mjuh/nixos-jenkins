{
  environment.interactiveShellInit = ''
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export XDG_RUNTIME_DIR=/run/user/$UID
  '';

  networking = {
    extraHosts = ''
      127.0.0.1 jenkins.intr
    '';
  };

  nix = {
    trustedUsers = [ "root" "eng" ];
  };

  services = {
    openssh = {
      enable = true;
    };
  };
}

