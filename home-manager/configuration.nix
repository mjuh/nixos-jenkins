{ pkgs, nixosConfigurations, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host gitlab.intr
      User git
      HostName gitlab.intr
      IdentityFile /var/lib/jenkins/.ssh/ssh_deploy_key

      Host github.com
      User git
      IdentityFile /var/lib/jenkins/.ssh/ssh_deploy_key
    '';
    userKnownHostsFile = builtins.toFile "ssh_known_hosts"
      nixosConfigurations.jenkins.config.environment.etc."ssh/ssh_known_hosts".text;
  };
}
