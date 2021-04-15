{ config, pkgs, inputs, system, ... }:

{
  environment.systemPackages = (with pkgs; [
    gron

    (callPackage ./pkgs/system/default.nix { })
    # androidemu
    # addsshnode
    bind
    # cached-nix-shell
    file
    findutils
    gcc9
    # genjenkplugins
    git
    htop
    iotop
    iputils
    jdk
    jq
    killall
    kvm
    netcat
    nettools
    nix-generate-from-cpan
    nix-prefetch-docker
    nix-prefetch-git
    nodejs
    python27Full
    # ripgrep
    rsync
    screen
    skopeo
    sysstat
    tmux
    tree
    wget
    yq
    smartmontools
    sg3_utils
    unzip
  ]) ++ (with (import inputs.nixpkgs-vulnix { inherit system; }); [
    vulnix
  ]);
}
