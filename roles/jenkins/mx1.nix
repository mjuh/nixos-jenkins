{ config, ... }:

{

  services.openssh = {
    permitRootLogin = "yes";
    enable = true;
    listenAddresses = [{
      addr = (builtins.head
        config.networking.interfaces.vlan253.ipv4.addresses).address;
      port = 22;
    }];
  };

}
