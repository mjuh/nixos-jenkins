self: super: rec {
  inherit (super) callPackage;
  jenkins = super.jenkins.overrideAttrs (old: rec {
    version = "2.267";
    src = super.fetchurl {
#https://updates.jenkins.io/download/war/2.267/jenkins.war
      url = "https://updates.jenkins.io/download/war/${version}/jenkins.war";
      sha256 = "1ykd51jsa6nj2wv8hgg77f4vivxvz3375b9p5hkwf38p78gjba8g";
    };
  });
}
