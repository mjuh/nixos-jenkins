{ fetchurl, stdenv, lib }:

let inherit (lib) any init last attrValues concatStringsSep filterAttrs hasPrefix head splitString;
in filterAttrs (name: value:
  any (pkg: (hasPrefix pkg name)) (map (drv:
    concatStringsSep ""
      (init (splitString "." (last (splitString "/" (head (drv.src.urls)))))))
    (attrValues
      (import ./jenkinsPlugins.nix { inherit fetchurl stdenv; }))))
  (import ./plugins-all.nix { inherit fetchurl stdenv; })
