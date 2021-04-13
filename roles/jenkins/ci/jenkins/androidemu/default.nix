{ stdenv, ... }:

with import <nixpkgs> {
config.android_sdk.accept_license = true;
};

androidenv.emulateApp {
  name = "androidemu";
#  app = "/home/user/Downloads/app-release.apk";
#  platformVersion = "18";
#  useGoogleAPIs = false;
#  enableGPU = true;
#  abiVersion = "x86";
  
#  package = "com.rovio.angrybirds";
#  activity = "com.rovio.fusion.App";

#  avdHomeDir = "$HOME/.angrybirds";
}
