{ pkgs }:
 
let fhs = pkgs.buildFHSUserEnv {
  name = "android-env";
  targetPkgs = pkgs: with pkgs;
    [ git
      gitRepo
      gnupg
      python2
      curl
      procps
      openssl
      gnumake
      nettools
      androidenv
#      androidenv.composeAndroidPackages
      jdk
      schedtool
      utillinux
      m4
      gperf
      perl
      libxml2
      zip
      unzip
      bison
      flex
      lzop
    ];
  multiPkgs = pkgs: with pkgs;
    [ zlib
    ];
  runScript = "bash";
  profile = ''
    export USE_CCACHE=1
    export ANDROID_JAVA_HOME=${pkgs.jdk.home}
  '';
};
in pkgs.stdenv.mkDerivation {
  name = "android-env-shell";
  nativeBuildInputs = [ fhs ];
  shellHook = "exec android-env";

}
