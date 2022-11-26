{ config, lib, ... }:

let
  listenAddress = with lib;
    let
      interfacesVlan253 =
        filterAttrs
          (name: _: builtins.match "(([[:alpha:]]\|-)*253+.*)" name != null)
          config.networking.interfaces;
    in
      if interfacesVlan253 == {}
      then
        "0.0.0.0"
      else
        (head (head (attrValues interfacesVlan253)).ipv4.addresses).address;
in {
  services.prometheus.exporters = {
    node = {
      enable = true;
      inherit listenAddress;
      enabledCollectors = [ "systemd" "logind" "processes" ];
    };
  };
}
