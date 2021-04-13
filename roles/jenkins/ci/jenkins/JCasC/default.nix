{ stdenv }:

stdenv.mkDerivation rec {
      name = "jenkins-jcasc-config";
      src = ./src;
      installPhase = ''
         mkdir -p $out
         cp -pr $src/* $out
      '';
}

