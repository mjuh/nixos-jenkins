{ config, pkgs, options, ... }:
{
  programs.adb.enable = true;
  users.users.jenkins.extraGroups = ["adbusers"];
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  nixpkgs.config.android_sdk.accept_license = true;
  systemd.services.androidemu.enable = true;
  systemd.user.services.xinitrc.wantedBy = [ "default.target" ];
  systemd.services.androidemu.serviceConfig.Type = "oneshot";
  systemd.services.androidemu.serviceConfig.RemainAfterExit = true;
  systemd.services.androidemu.script = ''
   ANDROID_JAVA_HOME=${pkgs.jdk.home} JAVA_HOME=${pkgs.jdk.home} NIX_ANDROID_EMULATOR_FLAGS="-no-window" ${pkgs.androidemu}/bin/run-test-emulator   
  '';
}
