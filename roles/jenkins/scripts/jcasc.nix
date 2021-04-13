{ stdenv, writeScript, bash, curl, curlCmd, jenkinsUrl, jenkins-jcasc-config }:

let
  jcascAction = action:
    curlCmd [
      "--request" "POST"
      "--upload-file" "\${1:-${jenkins-jcasc-config.out + "/jenkins.yml"}}"
      (jenkinsUrl + "/configuration-as-code/" + action)
    ];
in stdenv.mkDerivation {
  name = "jcasc";
  builder = writeScript "builder.sh" (''
    source $stdenv/setup 
    mkdir -p $out/bin
    cat > $out/bin/jcasc <<'EOF'
  '' + builtins.concatStringsSep "\n" [
    ("#!" + bash + "/bin/bash")
    (jcascAction "apply || true")
    (jcascAction "replace")
  ] + "\n" + ''
    EOF
    chmod 555 $out/bin/jcasc
  '');
}
