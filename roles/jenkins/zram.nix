{ config, pkgs, ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    numDevices = 1;
    priority = 10;
    algorithm = "zstd" ;
  };
}

