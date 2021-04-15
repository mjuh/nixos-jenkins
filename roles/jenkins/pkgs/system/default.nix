{ stdenv, bash, writeScript }:

stdenv.mkDerivation {
  name = "system";
  builder = writeScript "builder.sh" (''
    source $stdenv/setup

    # Patch shebang phase
    cp ${../../scripts/system} system
    substituteInPlace system --replace "/usr/bin/env bash" ${bash}/bin/bash

    # Install phase
    mkdir -p $out/bin
    cp system $out/bin/system
    chmod 555 $out/bin/system
  '');
}
