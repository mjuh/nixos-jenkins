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

      Host kubernetes-nix.intr
      User root
      IdentityFile /var/lib/jenkins/.ssh/id_rsa_kubernetes_nixos_nix
    '';
  };
  home.file = {
    ".ssh/known_hosts" = {
      inherit (nixosConfigurations.jenkins.config.environment.etc."ssh/ssh_known_hosts") text;
    };
  };
}
