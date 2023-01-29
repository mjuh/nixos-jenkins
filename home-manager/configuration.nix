{ pkgs, nixosConfigurations, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host gitlab.intr
      User git
      HostName gitlab.intr

      Host github.com
      User git
      IdentityFile /var/lib/jenkins/.ssh/ssh_deploy_key
    '';
  };
  home.file = {
    ".ssh/known_hosts" = {
      inherit (nixosConfigurations.jenkins.config.environment.etc."ssh/ssh_known_hosts") text;
    };
  };
}
