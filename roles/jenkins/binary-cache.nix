{ config, inputs, system, ... }:
{
  services.nix-serve = {
    enable = true;
    secretKeyFile = "${inputs.ssl-certificates.packages.${system}.certificates}/nix-serve/cache-priv-key.pem";
  };
}
