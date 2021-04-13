{ stdenv, jenkins-job-builder }:

stdenv.mkDerivation rec {
  name = "jenkins-jobs-config";
  src = ./src;
  dontFixup = true; # Shebangs will be fixed in installPhase.
  installPhase = ''
     mkdir -p $out/bin
     for file in $src/*; do
        cp -pr $file .
        substituteInPlace $(basename $file) \
            --replace "/usr/bin/env -S jenkins-jobs" \
                ${jenkins-job-builder}/bin/jenkins-jobs
        install $(basename $file) $out/bin;
     done
  '';
}

