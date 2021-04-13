{ stdenv }:

stdenv.mkDerivation rec {
      name = "jenkins-add-node";
      src = ./src;
      installPhase = ''
         mkdir -p $out/bin
         cp -pr $src/* $out/bin
      '';
}

