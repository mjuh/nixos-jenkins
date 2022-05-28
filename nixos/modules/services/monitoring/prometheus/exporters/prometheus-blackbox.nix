{ config, ... }:

{
  services.prometheus.exporters.blackbox = {
    enable = true;
    extraFlags = [ "--log.level=debug" ];
    configFile = with builtins; toFile "prometheus-exporters-blackbox.json"
      (toJSON {
        modules = {
          http_2xx = {
            http = {
              no_follow_redirects = false;
              preferred_ip_protocol = "ip4";
              valid_http_versions = [ "HTTP/1.1" "HTTP/2" "HTTP/2.0" ];
              valid_status_codes = [];
            };
            prober = "http";
            timeout = "5s";
          };
        };
      });
  };
}

