{ stdenv }:

stdenv.mkDerivation rec {
      name = "jenkins-generate-plugins";
      src = ./src;
      installPhase = ''
         mkdir -p $out/bin
         cp -pr $src/* $out/bin
      '';
}

