{ stdenv, fetchurl }:
let
  mkJenkinsPlugin = { name, src }:
    stdenv.mkDerivation {
      inherit name src;
      phases = "installPhase";
      installPhase = "cp $src $out";
    };
in {
  ace-editor = mkJenkinsPlugin {
    name = "ace-editor";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ace-editor/1.1/ace-editor.hpi";
      sha256 =
        "abc97028893c8a71581a5f559ea48e8e1f1a65164faee96dabfed9e95e9abad2";
    };
  };
  ansicolor = mkJenkinsPlugin {
    name = "ansicolor";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ansicolor/1.0.2/ansicolor.hpi";
      sha256 =
        "983456b9ad72451dd577b33643ee2288c1cd729172e6ed666fba1852ae25f1e7";
    };
  };
  apache-httpcomponents-client-4-api = mkJenkinsPlugin {
    name = "apache-httpcomponents-client-4-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/apache-httpcomponents-client-4-api/4.5.13-138.v4e7d9a_7b_a_e61/apache-httpcomponents-client-4-api.hpi";
      sha256 =
        "468eb1f110b744b5c87cb6a5b619781f08b2200c9ca02e4456820e7220195aa8";
    };
  };
  authentication-tokens = mkJenkinsPlugin {
    name = "authentication-tokens";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/authentication-tokens/1.4/authentication-tokens.hpi";
      sha256 =
        "abf3344d603cec6b9a8608ab04b89b7a9fcfa01acc8b0fa049a4bf275e66cc6c";
    };
  };
  aws-java-sdk = mkJenkinsPlugin {
    name = "aws-java-sdk";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk/1.12.287-357.vf82d85a_6eefd/aws-java-sdk.hpi";
      sha256 =
        "f82f62ffbf4799ef613e917734682e574f002fc8850a7757d42cbf8808646720";
    };
  };
  aws-java-sdk-cloudformation = mkJenkinsPlugin {
    name = "aws-java-sdk-cloudformation";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-cloudformation/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-cloudformation.hpi";
      sha256 =
        "b7afc23e31a3cac8261206330e21860c3742cef0dd35e03960f09da8cd282869";
    };
  };
  aws-java-sdk-codebuild = mkJenkinsPlugin {
    name = "aws-java-sdk-codebuild";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-codebuild/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-codebuild.hpi";
      sha256 =
        "7ccfd697bd744aa685c43ea84a41504f5eee96f332b4ad858fb65c14a001723b";
    };
  };
  aws-java-sdk-ec2 = mkJenkinsPlugin {
    name = "aws-java-sdk-ec2";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-ec2/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-ec2.hpi";
      sha256 =
        "756b918e6c9c7a034364043e748aa284e484ee1c45f32894d611fe7e3d5ea675";
    };
  };
  aws-java-sdk-ecr = mkJenkinsPlugin {
    name = "aws-java-sdk-ecr";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-ecr/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-ecr.hpi";
      sha256 =
        "d87b81998280afa684a9b0d08fdacff05640664360f3bb0ae1a9fef37fd71f4f";
    };
  };
  aws-java-sdk-ecs = mkJenkinsPlugin {
    name = "aws-java-sdk-ecs";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-ecs/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-ecs.hpi";
      sha256 =
        "20b8e5013f0eb63b5d835e806178fd5dd5635a826d33dd89acb14fd54d00da2f";
    };
  };
  aws-java-sdk-efs = mkJenkinsPlugin {
    name = "aws-java-sdk-efs";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-efs/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-efs.hpi";
      sha256 =
        "b3d6971505bfd1336d855942aad08e8920cbea16425801958d1395d1a1cb00da";
    };
  };
  aws-java-sdk-elasticbeanstalk = mkJenkinsPlugin {
    name = "aws-java-sdk-elasticbeanstalk";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-elasticbeanstalk/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-elasticbeanstalk.hpi";
      sha256 =
        "1bcc6d047cd9975ff067bca2e6d9db353aca6bbec011cddb1052db11af3f1b62";
    };
  };
  aws-java-sdk-iam = mkJenkinsPlugin {
    name = "aws-java-sdk-iam";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-iam/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-iam.hpi";
      sha256 =
        "3e792cd0a80351cfed146299fdb8a228605291dd6682abaa8f1588683efdca1b";
    };
  };
  aws-java-sdk-logs = mkJenkinsPlugin {
    name = "aws-java-sdk-logs";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-logs/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-logs.hpi";
      sha256 =
        "a9aaf2040d19ca38b652fd40f9085c74be91530fa3e6a3c02f9d507b470c99d0";
    };
  };
  aws-java-sdk-minimal = mkJenkinsPlugin {
    name = "aws-java-sdk-minimal";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-minimal/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-minimal.hpi";
      sha256 =
        "67b1498d24070068afb68269650c35c22d6e4d8f4a54d80b4a1459a09ad1ff0b";
    };
  };
  aws-java-sdk-sns = mkJenkinsPlugin {
    name = "aws-java-sdk-sns";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-sns/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-sns.hpi";
      sha256 =
        "50c9ac3eb82ab73a87e8f19ad2720fd307f9a46006a6e69dbebde2fe23722160";
    };
  };
  aws-java-sdk-sqs = mkJenkinsPlugin {
    name = "aws-java-sdk-sqs";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-sqs/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-sqs.hpi";
      sha256 =
        "3c244fa2ab893cd62e69b77c346b281d1f3786bc9dc0baaf05d79170044d694b";
    };
  };
  aws-java-sdk-ssm = mkJenkinsPlugin {
    name = "aws-java-sdk-ssm";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/aws-java-sdk-ssm/1.12.287-357.vf82d85a_6eefd/aws-java-sdk-ssm.hpi";
      sha256 =
        "8cb8ef54929bdb75e21967234fcbd901ed65f118535d466728c7d68b034c300b";
    };
  };
  blueocean = mkJenkinsPlugin {
    name = "blueocean";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean/1.25.8/blueocean.hpi";
      sha256 =
        "b41c157b65540dd04a76ead06d7bb72a9a3313c53e5f7c3795309f3b3de82abc";
    };
  };
  blueocean-autofavorite = mkJenkinsPlugin {
    name = "blueocean-autofavorite";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-autofavorite/1.2.5/blueocean-autofavorite.hpi";
      sha256 =
        "274679e99b23b03dc4203df76b34966cc317fbb6cb46149eeec88770c6999146";
    };
  };
  blueocean-bitbucket-pipeline = mkJenkinsPlugin {
    name = "blueocean-bitbucket-pipeline";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-bitbucket-pipeline/1.25.8/blueocean-bitbucket-pipeline.hpi";
      sha256 =
        "8ae76e7f34956066b54f09c42ba82f48a63d8b3edf7af1dca440866fd3a30e50";
    };
  };
  blueocean-commons = mkJenkinsPlugin {
    name = "blueocean-commons";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-commons/1.25.8/blueocean-commons.hpi";
      sha256 =
        "ba1d63a3f4b42d461c0a95d7fe2b53b5718fe520c80f6b3a92c3e4cb526d0f85";
    };
  };
  blueocean-config = mkJenkinsPlugin {
    name = "blueocean-config";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-config/1.25.8/blueocean-config.hpi";
      sha256 =
        "a63c721b792a24d8725d6750579bc1ccd59b2eb3d60fe2fc2af122084db889e7";
    };
  };
  blueocean-core-js = mkJenkinsPlugin {
    name = "blueocean-core-js";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-core-js/1.25.8/blueocean-core-js.hpi";
      sha256 =
        "8d24bb8367f6a8a8e647e43b697e25c0b2b206fff2e9eaa2a95dfd5707906173";
    };
  };
  blueocean-dashboard = mkJenkinsPlugin {
    name = "blueocean-dashboard";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-dashboard/1.25.8/blueocean-dashboard.hpi";
      sha256 =
        "41a5fcaaa025f2fdb3145c250b99cdc18736ae0ec52a418cbd5d1c7f75ddac3c";
    };
  };
  blueocean-display-url = mkJenkinsPlugin {
    name = "blueocean-display-url";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-display-url/2.4.1/blueocean-display-url.hpi";
      sha256 =
        "f4179b8221e6c330317bd8a037d4074a03361290687a25c162335ee82710b303";
    };
  };
  blueocean-events = mkJenkinsPlugin {
    name = "blueocean-events";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-events/1.25.8/blueocean-events.hpi";
      sha256 =
        "6ab1223a935e1c1b36827dc688daf4021b8485fe620f50047500e58298d868c5";
    };
  };
  blueocean-executor-info = mkJenkinsPlugin {
    name = "blueocean-executor-info";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-executor-info/1.25.8/blueocean-executor-info.hpi";
      sha256 =
        "e17b518380a074e62006b83a41e063f77b8f2729490a83f865d0188e6b9cd496";
    };
  };
  blueocean-git-pipeline = mkJenkinsPlugin {
    name = "blueocean-git-pipeline";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-git-pipeline/1.25.8/blueocean-git-pipeline.hpi";
      sha256 =
        "c38e0519f66b3b0d0ebec1378db9bd4d1462ae13c7c59748b3a721d8f7f5af29";
    };
  };
  blueocean-github-pipeline = mkJenkinsPlugin {
    name = "blueocean-github-pipeline";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-github-pipeline/1.25.8/blueocean-github-pipeline.hpi";
      sha256 =
        "337657751f7bc65910a6d138108915a0ccb63773ae25fcf8c7b0f6171be2f274";
    };
  };
  blueocean-i18n = mkJenkinsPlugin {
    name = "blueocean-i18n";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-i18n/1.25.8/blueocean-i18n.hpi";
      sha256 =
        "5446a7f0dd183855f9d80624d6c44a2b5aa5093358f8475f9a0967c2936a2b42";
    };
  };
  blueocean-jwt = mkJenkinsPlugin {
    name = "blueocean-jwt";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-jwt/1.25.8/blueocean-jwt.hpi";
      sha256 =
        "4a58fd10f592f526efc39419da3219af4df8dffbf0880b66605dbd006ef9ea7e";
    };
  };
  blueocean-personalization = mkJenkinsPlugin {
    name = "blueocean-personalization";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-personalization/1.25.8/blueocean-personalization.hpi";
      sha256 =
        "2af8fc76d94df9a6f6a8f2348a970176346ce66744dd37e822ee9126b3d2c168";
    };
  };
  blueocean-pipeline-api-impl = mkJenkinsPlugin {
    name = "blueocean-pipeline-api-impl";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-pipeline-api-impl/1.25.8/blueocean-pipeline-api-impl.hpi";
      sha256 =
        "4423466a5cdce92a0b497dceac0002bb717c134fbd6cae65800b90a5ef040562";
    };
  };
  blueocean-pipeline-editor = mkJenkinsPlugin {
    name = "blueocean-pipeline-editor";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-pipeline-editor/1.25.8/blueocean-pipeline-editor.hpi";
      sha256 =
        "9648e6582d10eb93f960ac80c425670818944168137dd63a2a518557cef73f5e";
    };
  };
  blueocean-pipeline-scm-api = mkJenkinsPlugin {
    name = "blueocean-pipeline-scm-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-pipeline-scm-api/1.25.8/blueocean-pipeline-scm-api.hpi";
      sha256 =
        "137b24789b047673bd175939012ba0cb4248eaa200a059227419c45f0d12c559";
    };
  };
  blueocean-rest = mkJenkinsPlugin {
    name = "blueocean-rest";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-rest/1.25.8/blueocean-rest.hpi";
      sha256 =
        "173630cb093708a46558ac881b8b54fedd511d29b3e7165eb8b90e210b5e3fc0";
    };
  };
  blueocean-rest-impl = mkJenkinsPlugin {
    name = "blueocean-rest-impl";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-rest-impl/1.25.8/blueocean-rest-impl.hpi";
      sha256 =
        "ee31a87c34fa5dde5166604dfc3d79ee079fbb3d84e8c97ab318a3a39a63ad2e";
    };
  };
  blueocean-web = mkJenkinsPlugin {
    name = "blueocean-web";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/blueocean-web/1.25.8/blueocean-web.hpi";
      sha256 =
        "0d71860749c2ca01611a21e7a7b15424233cd5a238d0f82b91c7f9678d6881f9";
    };
  };
  bootstrap5-api = mkJenkinsPlugin {
    name = "bootstrap5-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/bootstrap5-api/5.2.1-3/bootstrap5-api.hpi";
      sha256 =
        "42f150cefd03b878bccb498218de68c526b1ca3def60dcd3901caadbee881f5a";
    };
  };
  bouncycastle-api = mkJenkinsPlugin {
    name = "bouncycastle-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/bouncycastle-api/2.26/bouncycastle-api.hpi";
      sha256 =
        "2b9ec2bd9bee111ff985fec297e1d78c20812daad0c273e41baf2580b0cbee9c";
    };
  };
  branch-api = mkJenkinsPlugin {
    name = "branch-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/branch-api/2.1051.v9985666b_f6cc/branch-api.hpi";
      sha256 =
        "0442cff0d674da80cf955f6b8b4f7362850a4a508cdc05607872fd59fd9a8d5b";
    };
  };
  caffeine-api = mkJenkinsPlugin {
    name = "caffeine-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/caffeine-api/2.9.3-65.v6a_47d0f4d1fe/caffeine-api.hpi";
      sha256 =
        "649fb9a4f730024d30b4890182e9d1c41ff388664fd81786b6cf5ddf9367d89e";
    };
  };
  checks-api = mkJenkinsPlugin {
    name = "checks-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/checks-api/1.8.0/checks-api.hpi";
      sha256 =
        "f3a1b4be4108cfba5099dcb48c9e7598394a4043d4fe895ea6c83d7aeced0766";
    };
  };
  cloudbees-bitbucket-branch-source = mkJenkinsPlugin {
    name = "cloudbees-bitbucket-branch-source";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/cloudbees-bitbucket-branch-source/791.vb_eea_a_476405b/cloudbees-bitbucket-branch-source.hpi";
      sha256 =
        "d08bf0e5ae7774c999513d2112a2112dd4ef34c6265988e6a1cd1fc2af76f4f8";
    };
  };
  cloudbees-disk-usage-simple = mkJenkinsPlugin {
    name = "cloudbees-disk-usage-simple";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/cloudbees-disk-usage-simple/178.v1a_4d2f6359a_8/cloudbees-disk-usage-simple.hpi";
      sha256 =
        "ac41a4c6c85faf9900c2c19e55183dc6e1e53c22563e207211632a2be384b5f7";
    };
  };
  cloudbees-folder = mkJenkinsPlugin {
    name = "cloudbees-folder";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/cloudbees-folder/6.795.v3e23d3c6f194/cloudbees-folder.hpi";
      sha256 =
        "4b5a0c3a09a6752ce0044927b81b4276268e33a210bb42d257dbfdf7f5b705b1";
    };
  };
  command-launcher = mkJenkinsPlugin {
    name = "command-launcher";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/command-launcher/90.v669d7ccb_7c31/command-launcher.hpi";
      sha256 =
        "38e6bf4f404d2f8264b338b773a1c930e12143f97c18bd67d6c9661427a6ada8";
    };
  };
  commons-lang3-api = mkJenkinsPlugin {
    name = "commons-lang3-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/commons-lang3-api/3.12.0-36.vd97de6465d5b_/commons-lang3-api.hpi";
      sha256 =
        "98dfff9f21370d6808392fd811f90a6e173e705970309877596032be1b917ad1";
    };
  };
  commons-text-api = mkJenkinsPlugin {
    name = "commons-text-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/commons-text-api/1.10.0-27.vb_fa_3896786a_7/commons-text-api.hpi";
      sha256 =
        "88f3857141101809cc58f120e736b2dea11edb4b4fda6e6e45d86989f760337e";
    };
  };
  conditional-buildstep = mkJenkinsPlugin {
    name = "conditional-buildstep";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/conditional-buildstep/1.4.2/conditional-buildstep.hpi";
      sha256 =
        "919be166db7b7f90c1445b7dd37981e60880929362908439ba20cb25799fc98f";
    };
  };
  config-file-provider = mkJenkinsPlugin {
    name = "config-file-provider";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/config-file-provider/3.11.1/config-file-provider.hpi";
      sha256 =
        "c026f18419f3f67521ebcfb3c58797f3f3acf27766919ef3d40691eeedf3761b";
    };
  };
  configuration-as-code = mkJenkinsPlugin {
    name = "configuration-as-code";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/configuration-as-code/1569.vb_72405b_80249/configuration-as-code.hpi";
      sha256 =
        "853fa7fcb19fa4d0b661ef8df953b2cf1c8e8727a8a51370dd92cd3b1ed9c56f";
    };
  };
  credentials = mkJenkinsPlugin {
    name = "credentials";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/credentials/1214.v1de940103927/credentials.hpi";
      sha256 =
        "89a468e0ea3be564bd5f4390187f8005f730f333a5786b6004cd96d4111e0c4d";
    };
  };
  credentials-binding = mkJenkinsPlugin {
    name = "credentials-binding";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/credentials-binding/523.vd859a_4b_122e6/credentials-binding.hpi";
      sha256 =
        "0a9e850728268d2750fe941ef63e35ca0eb42dfa3f425056cbd630a90d9d089a";
    };
  };
  data-tables-api = mkJenkinsPlugin {
    name = "data-tables-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/data-tables-api/1.12.1-4/data-tables-api.hpi";
      sha256 =
        "3328130763f6f27e270f1dc662e611470dc9f089f25c7177f4d4902610de1eec";
    };
  };
  display-url-api = mkJenkinsPlugin {
    name = "display-url-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/display-url-api/2.3.6/display-url-api.hpi";
      sha256 =
        "3f4e987912dcf1acfcc5381c4b41a0e670b6cb45dad8ed2b793893fd9b8fdfd5";
    };
  };
  docker-commons = mkJenkinsPlugin {
    name = "docker-commons";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/docker-commons/1.21/docker-commons.hpi";
      sha256 =
        "c9ef4b3bfe83f037d8e00d12bb7801d0676450a64f9361be3e7f524930e26a26";
    };
  };
  docker-workflow = mkJenkinsPlugin {
    name = "docker-workflow";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/docker-workflow/528.v7c193a_0b_e67c/docker-workflow.hpi";
      sha256 =
        "a4c7c5f2ce4401a1c0baa7d8f62601330bb7e84a07fc3a32cfb872696fa32825";
    };
  };
  durable-task = mkJenkinsPlugin {
    name = "durable-task";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/durable-task/501.ve5d4fc08b0be/durable-task.hpi";
      sha256 =
        "19c16a3958e78af55e3ea906f4c87ae1ec49488f0c47c87e79eb446f0f290adc";
    };
  };
  echarts-api = mkJenkinsPlugin {
    name = "echarts-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/echarts-api/5.4.0-1/echarts-api.hpi";
      sha256 =
        "9cebfa70d840c69871ff524b232331cdec4f658fb748dbc7a61fdbc06d93b286";
    };
  };
  favorite = mkJenkinsPlugin {
    name = "favorite";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/favorite/2.4.1/favorite.hpi";
      sha256 =
        "76c63416402cd2588398ba3c3808935d209a2f00011d5410fb271fb06d8a2f58";
    };
  };
  font-awesome-api = mkJenkinsPlugin {
    name = "font-awesome-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/font-awesome-api/6.2.1-1/font-awesome-api.hpi";
      sha256 =
        "f2aee4ee373da672d898ed557a5648e1dc05575263428a567e0dfea4e6bd468d";
    };
  };
  git = mkJenkinsPlugin {
    name = "git";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/git/4.14.0/git.hpi";
      sha256 =
        "d7ab4e619ec6f7104222682cebe0d33cb60d793860a33acd3c49dc740955c401";
    };
  };
  git-client = mkJenkinsPlugin {
    name = "git-client";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/git-client/3.13.0/git-client.hpi";
      sha256 =
        "cf887f1ee38e661f99e74ff1286a674a562705ce636456293c711dca0dd46dfd";
    };
  };
  github = mkJenkinsPlugin {
    name = "github";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/github/1.36.0/github.hpi";
      sha256 =
        "918092553e04ece135f913b8001bfe5b8134ec83e677f8551b7c3224c8560612";
    };
  };
  github-api = mkJenkinsPlugin {
    name = "github-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/github-api/1.303-400.v35c2d8258028/github-api.hpi";
      sha256 =
        "dbcbf194f918a15193f75718283cd9ae9332eb0dde5a8fa356ee2399c9c9f502";
    };
  };
  github-branch-source = mkJenkinsPlugin {
    name = "github-branch-source";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/github-branch-source/1696.v3a_7603564d04/github-branch-source.hpi";
      sha256 =
        "d5207b459bea0960e122c0f1ccc8f3909a7566e64d2f8ea48f4f384c79828f22";
    };
  };
  gitlab-api = mkJenkinsPlugin {
    name = "gitlab-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/gitlab-api/5.0.1-78.v47a_45b_9f78b_7/gitlab-api.hpi";
      sha256 =
        "ac497fe6e13d25bb242af8c119637992487ad851b04a3d24677159264e0053e7";
    };
  };
  gitlab-branch-source = mkJenkinsPlugin {
    name = "gitlab-branch-source";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/gitlab-branch-source/642.v9ed86b_b_54384/gitlab-branch-source.hpi";
      sha256 =
        "ba723707882b40b9aa1e6cdb6bf59a0d90903c56c5acc7d71358efbbfb18803b";
    };
  };
  gradle = mkJenkinsPlugin {
    name = "gradle";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/gradle/2.1.1/gradle.hpi";
      sha256 =
        "c8dd7e1d35b4d7d7314079d70cd602ab2c7116475439f0b98fd2e56a8b0f3a3d";
    };
  };
  handy-uri-templates-2-api = mkJenkinsPlugin {
    name = "handy-uri-templates-2-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/handy-uri-templates-2-api/2.1.8-22.v77d5b_75e6953/handy-uri-templates-2-api.hpi";
      sha256 =
        "622e336f6cf1b55ce6b4a6934ed176e76eec87c361f83e27dfb4c6eb4fca3bd5";
    };
  };
  hashicorp-vault-plugin = mkJenkinsPlugin {
    name = "hashicorp-vault-plugin";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/hashicorp-vault-plugin/359.v2da_3b_45f17d5/hashicorp-vault-plugin.hpi";
      sha256 =
        "627ced0093023c6b26a6752b965431497fd3c5ea805b18263319e377fa0e3a75";
    };
  };
  htmlpublisher = mkJenkinsPlugin {
    name = "htmlpublisher";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/htmlpublisher/1.31/htmlpublisher.hpi";
      sha256 =
        "8105294247f4b37c2b8812e86658dbd28f05eb1460efbeb690de3345dd628aa9";
    };
  };
  instance-identity = mkJenkinsPlugin {
    name = "instance-identity";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/instance-identity/116.vf8f487400980/instance-identity.hpi";
      sha256 =
        "f64918f341feeb429e6c068254c52d899674d296dce9255c1cfcb4b4743631e4";
    };
  };
  ionicons-api = mkJenkinsPlugin {
    name = "ionicons-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ionicons-api/31.v4757b_6987003/ionicons-api.hpi";
      sha256 =
        "ad83aa360c2c323c0c2e2303e9b86fdf8e5dd3d905e0dbe293922e04316e18ea";
    };
  };
  jackson2-api = mkJenkinsPlugin {
    name = "jackson2-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jackson2-api/2.13.4.20221013-295.v8e29ea_354141/jackson2-api.hpi";
      sha256 =
        "b75227a985c32f54cac9c947a652b45283be4279ed4ae8887d5d4c3c95c46294";
    };
  };
  jakarta-activation-api = mkJenkinsPlugin {
    name = "jakarta-activation-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jakarta-activation-api/2.0.1-2/jakarta-activation-api.hpi";
      sha256 =
        "69da2e000e1ad5396a79232ba01f8b415f3f84333914a9651ebdf405d25eb20c";
    };
  };
  jakarta-mail-api = mkJenkinsPlugin {
    name = "jakarta-mail-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jakarta-mail-api/2.0.1-2/jakarta-mail-api.hpi";
      sha256 =
        "9749b4f012cb5c6d23e8c3835e053f7e1abc097c715b395e799f0e9cc9550c31";
    };
  };
  javadoc = mkJenkinsPlugin {
    name = "javadoc";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/javadoc/226.v71211feb_e7e9/javadoc.hpi";
      sha256 =
        "a2913b6b99f0d204400ddfcbf6ef50edaa0e869a4f0fde2c38f13432943a762d";
    };
  };
  javax-activation-api = mkJenkinsPlugin {
    name = "javax-activation-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/javax-activation-api/1.2.0-5/javax-activation-api.hpi";
      sha256 =
        "a7769eb7a99e4f5f008af09e6d90610c5270a19677adc26ffd98e5eeb8dddb23";
    };
  };
  jaxb = mkJenkinsPlugin {
    name = "jaxb";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jaxb/2.3.7-1/jaxb.hpi";
      sha256 =
        "44a12a25fc976beb49f2db682db402e518b2b379c40c89e23739eb7c63df3a6c";
    };
  };
  jdk-tool = mkJenkinsPlugin {
    name = "jdk-tool";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jdk-tool/63.v62d2fd4b_4793/jdk-tool.hpi";
      sha256 =
        "3e4d0c8a3500046ff0baf3d375564a3591d3cc75a117c624ba9dbbe9296418db";
    };
  };
  jenkins-design-language = mkJenkinsPlugin {
    name = "jenkins-design-language";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jenkins-design-language/1.25.8/jenkins-design-language.hpi";
      sha256 =
        "0defe768120214e6fa1bc470d32486614e31905d9e625827ed71ebdf44dbcd3c";
    };
  };
  jersey2-api = mkJenkinsPlugin {
    name = "jersey2-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jersey2-api/2.37-1/jersey2-api.hpi";
      sha256 =
        "e14aac4b19edaadcdc58cdbfe62bd62ab1cbfa656b8b178dca6b761af201a9de";
    };
  };
  jjwt-api = mkJenkinsPlugin {
    name = "jjwt-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jjwt-api/0.11.5-77.v646c772fddb_0/jjwt-api.hpi";
      sha256 =
        "cc10fc60c47fe60a585224dad45dde166dd0268cf6efc9967fbf870e3601ceb2";
    };
  };
  job-dsl = mkJenkinsPlugin {
    name = "job-dsl";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/job-dsl/1.81/job-dsl.hpi";
      sha256 =
        "b1a2314102af02cf221e18bdc74cfa582e3e5ce35306c730f2dc7082893a82f6";
    };
  };
  jquery3-api = mkJenkinsPlugin {
    name = "jquery3-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jquery3-api/3.6.1-2/jquery3-api.hpi";
      sha256 =
        "13f97355ec4c3bab3da770276f827fba295a1f8bc00f38d2b0a9ccb79a61ad57";
    };
  };
  jsch = mkJenkinsPlugin {
    name = "jsch";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/jsch/0.1.55.61.va_e9ee26616e7/jsch.hpi";
      sha256 =
        "8379691a06b084540ce6b70c11fc055720098d262b717cf46429a2afd6ca8ee6";
    };
  };
  junit = mkJenkinsPlugin {
    name = "junit";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/junit/1166.va_436e268e972/junit.hpi";
      sha256 =
        "d48428e104130a5def88c3e90b6624af35c76a8acf543104fa26370daaf5a04e";
    };
  };
  lockable-resources = mkJenkinsPlugin {
    name = "lockable-resources";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/lockable-resources/1069.v726298f53f8c/lockable-resources.hpi";
      sha256 =
        "eeb612804002a49914db9bc51551e5e15b10b34dc97e8e5812de5dd3e9e9f211";
    };
  };
  mailer = mkJenkinsPlugin {
    name = "mailer";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/mailer/438.v02c7f0a_12fa_4/mailer.hpi";
      sha256 =
        "ee52de400615ea293748cf6741aef7d7181cdd5d57a588eb1a51b904e36a3159";
    };
  };
  managed-scripts = mkJenkinsPlugin {
    name = "managed-scripts";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/managed-scripts/1.5.6/managed-scripts.hpi";
      sha256 =
        "72ae9dcd4085bdfbe810c1e04e30269520db6a1cefba339e34c13f39fa8384b8";
    };
  };
  mapdb-api = mkJenkinsPlugin {
    name = "mapdb-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/mapdb-api/1.0.9-28.vf251ce40855d/mapdb-api.hpi";
      sha256 =
        "b924749b6445270cd2ed881f81925fedd71f67a2993473b9172e1e7a9a4023be";
    };
  };
  matrix-project = mkJenkinsPlugin {
    name = "matrix-project";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/matrix-project/785.v06b_7f47b_c631/matrix-project.hpi";
      sha256 =
        "e42f01c243f2a5797649438cbf523b7a76b40d1ff3cf9075898fe1e824f2e525";
    };
  };
  maven-plugin = mkJenkinsPlugin {
    name = "maven-plugin";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/maven-plugin/3.20/maven-plugin.hpi";
      sha256 =
        "65d5b562fcb523bf2b7eddf560ac0998a83d91d219a52aeac1d9c814972e83b6";
    };
  };
  metrics = mkJenkinsPlugin {
    name = "metrics";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/metrics/4.2.10-405.v60a_9cc74e923/metrics.hpi";
      sha256 =
        "e4613e0730c62c78cc1ddf2c72849e61238f913d23bc6e8f64cee37efa899061";
    };
  };
  nexus-jenkins-plugin = mkJenkinsPlugin {
    name = "nexus-jenkins-plugin";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/nexus-jenkins-plugin/3.16.459.vcdf273b_29f8c/nexus-jenkins-plugin.hpi";
      sha256 =
        "32996360ce92835988ee29d830b41712dadd71844480f3b6d0d1f2aa39aa4986";
    };
  };
  node-iterator-api = mkJenkinsPlugin {
    name = "node-iterator-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/node-iterator-api/49.v58a_8b_35f8363/node-iterator-api.hpi";
      sha256 =
        "106b4ba84478412d2f7bb30fa7e4aad13c5235b235cfbbf62f072904342969ea";
    };
  };
  okhttp-api = mkJenkinsPlugin {
    name = "okhttp-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/okhttp-api/4.9.3-108.v0feda04578cf/okhttp-api.hpi";
      sha256 =
        "8f203819fccb921dc7144b630c35eea29cb62869605873372ae67261b84f04a4";
    };
  };
  parameterized-trigger = mkJenkinsPlugin {
    name = "parameterized-trigger";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/parameterized-trigger/2.45/parameterized-trigger.hpi";
      sha256 =
        "58d1441fb5cfb4837c67d4d87a8925f45d8e99a1472a8f8010fbecc0b6ecfed9";
    };
  };
  pipeline-build-step = mkJenkinsPlugin {
    name = "pipeline-build-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-build-step/2.18/pipeline-build-step.hpi";
      sha256 =
        "89a536ea792d325dcfc532b66733f0ad4511331e49c4202bbe45fb8b0ad049c8";
    };
  };
  pipeline-graph-analysis = mkJenkinsPlugin {
    name = "pipeline-graph-analysis";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-graph-analysis/195.v5812d95a_a_2f9/pipeline-graph-analysis.hpi";
      sha256 =
        "1456d4eff767acdea7748a59121a8e8d2fc0689f0ad683627116e5510f07ecdc";
    };
  };
  pipeline-groovy-lib = mkJenkinsPlugin {
    name = "pipeline-groovy-lib";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-groovy-lib/621.vb_44ce045b_582/pipeline-groovy-lib.hpi";
      sha256 =
        "dafa252e9f2a8adbdb1a99850c60941f1dff55ae20ba61cda71d87b540bcfffc";
    };
  };
  pipeline-input-step = mkJenkinsPlugin {
    name = "pipeline-input-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-input-step/466.v6d0a_5df34f81/pipeline-input-step.hpi";
      sha256 =
        "81fbb12caffea58e298d0662a2fff4cc2ad087b92718d917f5c00b63909a8fe0";
    };
  };
  pipeline-milestone-step = mkJenkinsPlugin {
    name = "pipeline-milestone-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-milestone-step/101.vd572fef9d926/pipeline-milestone-step.hpi";
      sha256 =
        "4f65cb6ec3f5aecc5743ef08f76b1cad7b9af3e845b48858104b15f5a3812690";
    };
  };
  pipeline-model-api = mkJenkinsPlugin {
    name = "pipeline-model-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-model-api/2.2118.v31fd5b_9944b_5/pipeline-model-api.hpi";
      sha256 =
        "ed6320e23aa3287f53ab1dedc4e56ad7c318479b6959b13c3b7f169ab2143377";
    };
  };
  pipeline-model-definition = mkJenkinsPlugin {
    name = "pipeline-model-definition";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-model-definition/2.2118.v31fd5b_9944b_5/pipeline-model-definition.hpi";
      sha256 =
        "0bba171131e7c8af33db91302879b0ad026b55dd0213a7fc78160e3ea0621e4d";
    };
  };
  pipeline-model-extensions = mkJenkinsPlugin {
    name = "pipeline-model-extensions";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-model-extensions/2.2118.v31fd5b_9944b_5/pipeline-model-extensions.hpi";
      sha256 =
        "44312fa6a8b93de1287be8f9269cb442a17518ec38b235751593674d4bbf07d8";
    };
  };
  pipeline-rest-api = mkJenkinsPlugin {
    name = "pipeline-rest-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-rest-api/2.28/pipeline-rest-api.hpi";
      sha256 =
        "3d5ac41e6b36800ecbc53c06a0a4f1502e3e3cdbf4fc44f9ac1c2ba291bb40e2";
    };
  };
  pipeline-stage-step = mkJenkinsPlugin {
    name = "pipeline-stage-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-stage-step/296.v5f6908f017a_5/pipeline-stage-step.hpi";
      sha256 =
        "bb8e8b55a17252a651a7c523656cb9437a55fd82028c6be7ec2b44a3805c642d";
    };
  };
  pipeline-stage-tags-metadata = mkJenkinsPlugin {
    name = "pipeline-stage-tags-metadata";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-stage-tags-metadata/2.2118.v31fd5b_9944b_5/pipeline-stage-tags-metadata.hpi";
      sha256 =
        "4cefb0f311c3b962c8b085bf54367d416121e7b011aede9af9ba34d9cc3eee53";
    };
  };
  pipeline-utility-steps = mkJenkinsPlugin {
    name = "pipeline-utility-steps";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pipeline-utility-steps/2.14.0/pipeline-utility-steps.hpi";
      sha256 =
        "e02e882d858e092e006a475fd7a55b9f2dfad0756c825b559a17bca48dfe4b7e";
    };
  };
  plain-credentials = mkJenkinsPlugin {
    name = "plain-credentials";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/plain-credentials/139.ved2b_9cf7587b/plain-credentials.hpi";
      sha256 =
        "dbbbd080cde74c6adf0b6eae9372ff1a5f4a9b18bbebba2ff4a5e509a6244c08";
    };
  };
  plugin-util-api = mkJenkinsPlugin {
    name = "plugin-util-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/plugin-util-api/2.18.0/plugin-util-api.hpi";
      sha256 =
        "8ae3041bf1537755ef6b52c130dcad8802158a96303607dc89d8fce311f03e5e";
    };
  };
  popper2-api = mkJenkinsPlugin {
    name = "popper2-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/popper2-api/2.11.6-2/popper2-api.hpi";
      sha256 =
        "0fce90d92a3faa7098b87c7c62c778d23fa31fc04b9ca0f175c55e81d94ce0db";
    };
  };
  project-inheritance = mkJenkinsPlugin {
    name = "project-inheritance";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/project-inheritance/21.04.03/project-inheritance.hpi";
      sha256 =
        "c7e714d2a096ceb719f9a91eb61d12c6da1619f139254ce91db1ead58520ecf7";
    };
  };
  prometheus = mkJenkinsPlugin {
    name = "prometheus";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/prometheus/2.0.11/prometheus.hpi";
      sha256 =
        "7cbb384331bd5c4dd7c5113b4bb0171ac3225e92c68588221b0943e53721c0ab";
    };
  };
  promoted-builds = mkJenkinsPlugin {
    name = "promoted-builds";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/promoted-builds/892.vd6219fc0a_efb/promoted-builds.hpi";
      sha256 =
        "1f0483c03cfd227a8d8e1924a08aeb43f23a2414dd7602ba4c4871e3a6447ea6";
    };
  };
  pubsub-light = mkJenkinsPlugin {
    name = "pubsub-light";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/pubsub-light/1.17/pubsub-light.hpi";
      sha256 =
        "34fe0892f8629417419af706648917c50b8ef2e766c3e7593ce2a570ca871395";
    };
  };
  rebuild = mkJenkinsPlugin {
    name = "rebuild";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/rebuild/1.34/rebuild.hpi";
      sha256 =
        "84e3ac4876488adb8649172ace2132a6fd887faf0809235154e40d330d912a74";
    };
  };
  resource-disposer = mkJenkinsPlugin {
    name = "resource-disposer";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/resource-disposer/0.20/resource-disposer.hpi";
      sha256 =
        "b287cdfdcc3921701fed05fbcbbb20e27ce30ec0501e0f01474e4db6d0d39fa5";
    };
  };
  run-condition = mkJenkinsPlugin {
    name = "run-condition";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/run-condition/1.5/run-condition.hpi";
      sha256 =
        "7ed94d7196676c00e45b5bf7e191831eee0e49770dced1c266b8055980b339ca";
    };
  };
  scm-api = mkJenkinsPlugin {
    name = "scm-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/scm-api/621.vda_a_b_055e58f7/scm-api.hpi";
      sha256 =
        "de49844880b567b71ce84153d7502a993d3bee87c948e0fad7408318bf0b61cb";
    };
  };
  script-security = mkJenkinsPlugin {
    name = "script-security";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/script-security/1218.v39ca_7f7ed0a_c/script-security.hpi";
      sha256 =
        "6b2dff95b33f7ed07c2adc1700823d9cf77c3b3a79e0437748e47217b827ff94";
    };
  };
  slack = mkJenkinsPlugin {
    name = "slack";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/slack/631.v40deea_40323b/slack.hpi";
      sha256 =
        "945a709bb4af3af621997facee4811d6ddccce70a6828200b625eadaaead7f7e";
    };
  };
  snakeyaml-api = mkJenkinsPlugin {
    name = "snakeyaml-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/snakeyaml-api/1.33-90.v80dcb_3814d35/snakeyaml-api.hpi";
      sha256 =
        "5e279d36ca66ef133989012745f78ab5c19b686cbb7ddd76b444c45573bd3386";
    };
  };
  sse-gateway = mkJenkinsPlugin {
    name = "sse-gateway";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/sse-gateway/1.26/sse-gateway.hpi";
      sha256 =
        "38b78116270163ced101c5d1689e367cd7549700495077ea235703e964f7214d";
    };
  };
  ssh-credentials = mkJenkinsPlugin {
    name = "ssh-credentials";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ssh-credentials/305.v8f4381501156/ssh-credentials.hpi";
      sha256 =
        "008ffb999ce9c7949c1299e1305007178bd0bedfd4c8401d6a4e92eeba635ff4";
    };
  };
  ssh-slaves = mkJenkinsPlugin {
    name = "ssh-slaves";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ssh-slaves/2.854.v7fd446b_337c9/ssh-slaves.hpi";
      sha256 =
        "0384320ec8dd0fb09468c88badcbe825d05efb0ac9cbc0bb214ed1547d9b837b";
    };
  };
  structs = mkJenkinsPlugin {
    name = "structs";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/structs/324.va_f5d6774f3a_d/structs.hpi";
      sha256 =
        "65dd0a68c663b08e30ed254f37549e9ccfab18d27e4f1182cc7eed6d4d02c958";
    };
  };
  subversion = mkJenkinsPlugin {
    name = "subversion";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/subversion/2.16.0/subversion.hpi";
      sha256 =
        "917049c0923ad9e563bc415ea4d503aecb23bbf100ce5d473ee5d1aae17f25e1";
    };
  };
  support-core = mkJenkinsPlugin {
    name = "support-core";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/support-core/1229.v84a_e1b_3a_1d32/support-core.hpi";
      sha256 =
        "3a464518d20f40f1eaa545fa002991c73881e43b0bb7a6081ca572094b595050";
    };
  };
  token-macro = mkJenkinsPlugin {
    name = "token-macro";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/token-macro/321.vd7cc1f2a_52c8/token-macro.hpi";
      sha256 =
        "095084f680c37f7d18d6468e2c4aecd74430f324c1d6ebb23d8551d34debdadb";
    };
  };
  trilead-api = mkJenkinsPlugin {
    name = "trilead-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/trilead-api/2.84.v72119de229b_7/trilead-api.hpi";
      sha256 =
        "72ee883ee83a94a0a84e9821123ae3f1eb09e7650896c5e0a78be8d0df50bde8";
    };
  };
  variant = mkJenkinsPlugin {
    name = "variant";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/variant/59.vf075fe829ccb/variant.hpi";
      sha256 =
        "14ac8250e7ff958e45d8e47c05d5cb495602a34737a7a2680e9e364798624fb3";
    };
  };
  vsphere-cloud = mkJenkinsPlugin {
    name = "vsphere-cloud";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/vsphere-cloud/2.27/vsphere-cloud.hpi";
      sha256 =
        "b584e8c515cdf41fa47740087677e11af80c402ef6c4fb5f153b9d8e05ccbdea";
    };
  };
  workflow-aggregator = mkJenkinsPlugin {
    name = "workflow-aggregator";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-aggregator/590.v6a_d052e5a_a_b_5/workflow-aggregator.hpi";
      sha256 =
        "3f4485827a8e045663c6474a39189051bae17657d6e5853bb4ea5ef396df1961";
    };
  };
  workflow-api = mkJenkinsPlugin {
    name = "workflow-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-api/1200.v8005c684b_a_c6/workflow-api.hpi";
      sha256 =
        "28ed84f80891877cd49a8ad81475e6263dbcd6530c6f1827e3be2ac325ebf60d";
    };
  };
  workflow-basic-steps = mkJenkinsPlugin {
    name = "workflow-basic-steps";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-basic-steps/994.vd57e3ca_46d24/workflow-basic-steps.hpi";
      sha256 =
        "f8590ef7e57683b304a63cc25f1d7f9717e91a9b63039fa02fd7d235aa0699fa";
    };
  };
  workflow-cps = mkJenkinsPlugin {
    name = "workflow-cps";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-cps/3536.vb_8a_6628079d5/workflow-cps.hpi";
      sha256 =
        "ec34e2b6f2862650aa6b1e0b3a173b51c483c6849b9ba66179051b998578646e";
    };
  };
  workflow-durable-task-step = mkJenkinsPlugin {
    name = "workflow-durable-task-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-durable-task-step/1217.v38306d8fa_b_5c/workflow-durable-task-step.hpi";
      sha256 =
        "f3d26f503a9b2937e5e4410859130869f27b4902df36131d6dca0ad163abee33";
    };
  };
  workflow-job = mkJenkinsPlugin {
    name = "workflow-job";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-job/1254.v3f64639b_11dd/workflow-job.hpi";
      sha256 =
        "09424c873be2bab34f78b7334fe79c9028ec1fd0115729277176e0681eda396d";
    };
  };
  workflow-multibranch = mkJenkinsPlugin {
    name = "workflow-multibranch";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-multibranch/716.vc692a_e52371b_/workflow-multibranch.hpi";
      sha256 =
        "9df7f291ed4d10a79e49c594b853eaa34934d0b83a19aaf57c9cff112ccefd00";
    };
  };
  workflow-scm-step = mkJenkinsPlugin {
    name = "workflow-scm-step";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-scm-step/400.v6b_89a_1317c9a_/workflow-scm-step.hpi";
      sha256 =
        "c0ed89da3228bfa5215b6a1724ca4a76dbbe2b939d8c4efdaa6a5a976a3145ed";
    };
  };
  workflow-step-api = mkJenkinsPlugin {
    name = "workflow-step-api";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-step-api/639.v6eca_cd8c04a_a_/workflow-step-api.hpi";
      sha256 =
        "e297994ef4892b292fed850431cafe5a687fe64fbb9ddf9b7938d2b74db81763";
    };
  };
  workflow-support = mkJenkinsPlugin {
    name = "workflow-support";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/workflow-support/839.v35e2736cfd5c/workflow-support.hpi";
      sha256 =
        "3fe54cab155ad9bac49d3a98df1377f5795f8acf556f829ac48b32f5567c02bd";
    };
  };
  ws-cleanup = mkJenkinsPlugin {
    name = "ws-cleanup";
    src = fetchurl {
      url =
        "https://updates.jenkins-ci.org/download/plugins/ws-cleanup/0.43/ws-cleanup.hpi";
      sha256 =
        "d85329a8045a640d68b0781e40a56446e180b39c1d050d4c8079e1ce98e0f6f9";
    };
  };
}
