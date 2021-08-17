{ stdenv, fetchurl }:
  let
    mkJenkinsPlugin = { name, src }:
      stdenv.mkDerivation {
        inherit name src;
        phases = "installPhase";
        installPhase = "cp \$src \$out";
        };
  in {
    ace-editor = mkJenkinsPlugin {
      name = "ace-editor";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/ace-editor/1.1/ace-editor.hpi";
        sha256 = "abc97028893c8a71581a5f559ea48e8e1f1a65164faee96dabfed9e95e9abad2";
        };
      };
    ansicolor = mkJenkinsPlugin {
      name = "ansicolor";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/ansicolor/1.0.0/ansicolor.hpi";
        sha256 = "9b774ea4c64ca7b56a6ccae9f07c51921ed13df71496bdab03981e4613074856";
        };
      };
    apache-httpcomponents-client-4-api = mkJenkinsPlugin {
      name = "apache-httpcomponents-client-4-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/apache-httpcomponents-client-4-api/4.5.13-1.0/apache-httpcomponents-client-4-api.hpi";
        sha256 = "1fa5adafcd043c582a9b6ec44a6a37166db77bb6d5b7d2c4f9902ad263a65636";
        };
      };
    async-http-client = mkJenkinsPlugin {
      name = "async-http-client";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/async-http-client/1.9.40.0/async-http-client.hpi";
        sha256 = "b1413a1b677e786a53adbf2c3e72aa6e6bf130baa52afa2ecc69d0fd7bc8ebbd";
        };
      };
    authentication-tokens = mkJenkinsPlugin {
      name = "authentication-tokens";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/authentication-tokens/1.4/authentication-tokens.hpi";
        sha256 = "abf3344d603cec6b9a8608ab04b89b7a9fcfa01acc8b0fa049a4bf275e66cc6c";
        };
      };
    bootstrap4-api = mkJenkinsPlugin {
      name = "bootstrap4-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/bootstrap4-api/4.6.0-3/bootstrap4-api.hpi";
        sha256 = "5ed055fc291662a02a01d3763aef9de5f3f0fb86ebe946e939a5dc27a87bd513";
        };
      };
    bootstrap5-api = mkJenkinsPlugin {
      name = "bootstrap5-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/bootstrap5-api/5.1.0-1/bootstrap5-api.hpi";
        sha256 = "99f11738abb1ba31c34f439400373284cecfb8fc5bca01d18e48005c6265c085";
        };
      };
    bouncycastle-api = mkJenkinsPlugin {
      name = "bouncycastle-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/bouncycastle-api/2.22/bouncycastle-api.hpi";
        sha256 = "2795848fdd0005273feb3b632fee5cebbd0a7e37c8b9e39ae87a11646e8a3c44";
        };
      };
    branch-api = mkJenkinsPlugin {
      name = "branch-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/branch-api/2.6.5/branch-api.hpi";
        sha256 = "4bddfed70aa589c5892aaff6588968b6acd1f26498d1f001165f4368a71e76b6";
        };
      };
    caffeine-api = mkJenkinsPlugin {
      name = "caffeine-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/caffeine-api/2.9.2-29.v717aac953ff3/caffeine-api.hpi";
        sha256 = "f505f5d151faf606f1e5633f741abff86229e88e09bed3dba63a9453698be68a";
        };
      };
    checks-api = mkJenkinsPlugin {
      name = "checks-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/checks-api/1.7.2/checks-api.hpi";
        sha256 = "effbec009c054395fd6052edea58887a16f3c4f96fbb86a14933fa9bcc9a8d0b";
        };
      };
    cloudbees-folder = mkJenkinsPlugin {
      name = "cloudbees-folder";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/cloudbees-folder/6.16/cloudbees-folder.hpi";
        sha256 = "5957009e62633cdcce83adac66aca3d7ff8e2039ab8a25e05380f295608b6430";
        };
      };
    command-launcher = mkJenkinsPlugin {
      name = "command-launcher";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/command-launcher/1.6/command-launcher.hpi";
        sha256 = "74c6f0b9375731ab5c9f7670ea340ff29f75360581f8b14ae6cd2b54d8ab07b7";
        };
      };
    conditional-buildstep = mkJenkinsPlugin {
      name = "conditional-buildstep";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/conditional-buildstep/1.4.1/conditional-buildstep.hpi";
        sha256 = "ebdd679e976af3062aac44eeef6b32529e4d91ab816c28db0c763bf111525a4c";
        };
      };
    config-file-provider = mkJenkinsPlugin {
      name = "config-file-provider";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/config-file-provider/3.8.1/config-file-provider.hpi";
        sha256 = "5b7a41987d257785d7bf79d46f1d27c4f4a54208e81dd5b9910c1c25bd84209d";
        };
      };
    configuration-as-code = mkJenkinsPlugin {
      name = "configuration-as-code";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/configuration-as-code/1.51/configuration-as-code.hpi";
        sha256 = "f88f3cb9b1696b62dc83538a89539347e93eea4d4802463cfade40cd501f3131";
        };
      };
    credentials = mkJenkinsPlugin {
      name = "credentials";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/credentials/2.5/credentials.hpi";
        sha256 = "ee6e1055e33cbd00ab59491b0303589f7f0c4060298ddcd097c502abbe32d228";
        };
      };
    credentials-binding = mkJenkinsPlugin {
      name = "credentials-binding";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/credentials-binding/1.27/credentials-binding.hpi";
        sha256 = "b909a9a49fb16d7ff9d5c7a5213263b75afeed50b3434266b195a81e47fcd7e3";
        };
      };
    display-url-api = mkJenkinsPlugin {
      name = "display-url-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/display-url-api/2.3.5/display-url-api.hpi";
        sha256 = "4a418820b9faa7f01cfa990b75ddc67f090809d3f9bd8b95707cd7840eb45209";
        };
      };
    docker-commons = mkJenkinsPlugin {
      name = "docker-commons";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/docker-commons/1.17/docker-commons.hpi";
        sha256 = "f8803889d00060616b9611f8f448b1b79e15304bc53c7b6b3f27da3ae39f77f4";
        };
      };
    docker-java-api = mkJenkinsPlugin {
      name = "docker-java-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/docker-java-api/3.1.5.2/docker-java-api.hpi";
        sha256 = "4b8820691ab7f58a62c5db20ae2c43e19c99cb7d7044f776a85b6689d7dd897e";
        };
      };
    docker-plugin = mkJenkinsPlugin {
      name = "docker-plugin";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/docker-plugin/1.2.2/docker-plugin.hpi";
        sha256 = "42f48e96ccd5eb74fbee306a615f8ec18fd0870ada9d07104da480ea3fcdcdac";
        };
      };
    durable-task = mkJenkinsPlugin {
      name = "durable-task";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/durable-task/1.39/durable-task.hpi";
        sha256 = "feacd3663df9cdf26e7b376516795f250102b5e3b21d0fc07edecc9f08a5e68c";
        };
      };
    echarts-api = mkJenkinsPlugin {
      name = "echarts-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/echarts-api/5.1.2-9/echarts-api.hpi";
        sha256 = "eb6d4344b6ccfe54d629c3c6b27262a0eaae9b80f59841cdb6ef6655f68c8901";
        };
      };
    font-awesome-api = mkJenkinsPlugin {
      name = "font-awesome-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/font-awesome-api/5.15.3-4/font-awesome-api.hpi";
        sha256 = "2ded09a76b3f26ebeb607b00d981b9abcbdd7722c51eb3c7f910635698f6d234";
        };
      };
    git = mkJenkinsPlugin {
      name = "git";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/git/4.8.1/git.hpi";
        sha256 = "8bbd93ff0cb45c58c91f8999191b11ae68ed166fcfc0b084b1e52e359778769e";
        };
      };
    git-client = mkJenkinsPlugin {
      name = "git-client";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/git-client/3.9.0/git-client.hpi";
        sha256 = "2e721684fa82cddbc2488cd11ad45ef24ca63ad06c571466da9e619afc2ee986";
        };
      };
    git-server = mkJenkinsPlugin {
      name = "git-server";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/git-server/1.10/git-server.hpi";
        sha256 = "34095b9ed64e9252dfa7591c8a49ce5e244732b0884325e9258670dae587a8b8";
        };
      };
    gitlab-api = mkJenkinsPlugin {
      name = "gitlab-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/gitlab-api/1.0.6/gitlab-api.hpi";
        sha256 = "8df3542ce45d7a594782653b7ab52d87d2b331f7f204a6691d3faa6ce57bd909";
        };
      };
    gitlab-branch-source = mkJenkinsPlugin {
      name = "gitlab-branch-source";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/gitlab-branch-source/1.5.8/gitlab-branch-source.hpi";
        sha256 = "5fb42eba8516884bb63c07e054a107f25b6f9d32cb870390bfb36e2489ddf592";
        };
      };
    gradle = mkJenkinsPlugin {
      name = "gradle";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/gradle/1.37.1/gradle.hpi";
        sha256 = "e657d3a6717cdfd3b58f2b0b796a478642acb1a2cbafe9c71cbdea3a905a31b3";
        };
      };
    handlebars = mkJenkinsPlugin {
      name = "handlebars";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/handlebars/3.0.8/handlebars.hpi";
        sha256 = "f7e21a44c88bcd2db3e40552e5972bb2b0cb85e5bf9bc571b29a4e0b65a4986d";
        };
      };
    handy-uri-templates-2-api = mkJenkinsPlugin {
      name = "handy-uri-templates-2-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/handy-uri-templates-2-api/2.1.8-1.0/handy-uri-templates-2-api.hpi";
        sha256 = "cd678d9809f695c7c40af1e8ee0a5e73efca07e2a3227fe60db1c3fb6d1d6fe8";
        };
      };
    hashicorp-vault-plugin = mkJenkinsPlugin {
      name = "hashicorp-vault-plugin";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/hashicorp-vault-plugin/3.8.0/hashicorp-vault-plugin.hpi";
        sha256 = "e5e4dd29f39bb6daf2c4773e56da8c8e189c3a824af7707d44f1f593c9c6424f";
        };
      };
    jackson2-api = mkJenkinsPlugin {
      name = "jackson2-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/jackson2-api/2.12.4/jackson2-api.hpi";
        sha256 = "f5961521396f02c0518af70816bf6b2c4d12a4ef7194a1d2db65235eff609602";
        };
      };
    javadoc = mkJenkinsPlugin {
      name = "javadoc";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/javadoc/1.6/javadoc.hpi";
        sha256 = "a5f2321aed9ec068781962114413f305665dfbcc89ba13bee9b797551de6bbc9";
        };
      };
    job-dsl = mkJenkinsPlugin {
      name = "job-dsl";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/job-dsl/1.77/job-dsl.hpi";
        sha256 = "7071a35d75d0593e3cbed695ba0cee41133f31753b87aeeea4c6e0624527b222";
        };
      };
    jquery3-api = mkJenkinsPlugin {
      name = "jquery3-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/jquery3-api/3.6.0-2/jquery3-api.hpi";
        sha256 = "09b75305611160148c572f76953a020278d64960768cb76f5e435a665170de4e";
        };
      };
    jsch = mkJenkinsPlugin {
      name = "jsch";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/jsch/0.1.55.2/jsch.hpi";
        sha256 = "cdc74bf8e43eb40ae6ad98ba2f866c8891408038699da9b836518a1d8923fc44";
        };
      };
    junit = mkJenkinsPlugin {
      name = "junit";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/junit/1.52/junit.hpi";
        sha256 = "6d1afa6843a6bd417a8d5b0204d1cfe493722286bb05606f00d29281b83dfc0a";
        };
      };
    lockable-resources = mkJenkinsPlugin {
      name = "lockable-resources";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/lockable-resources/2.11/lockable-resources.hpi";
        sha256 = "de118cc5e92e73959a3d8ecc0a08ef6c2218afaa973c32c35d30648ce2110532";
        };
      };
    mailer = mkJenkinsPlugin {
      name = "mailer";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/mailer/1.34/mailer.hpi";
        sha256 = "a38b98400d19155688471f3ff57390353f56e2773f8476e7bb78ed7a6f291d29";
        };
      };
    managed-scripts = mkJenkinsPlugin {
      name = "managed-scripts";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/managed-scripts/1.5.4/managed-scripts.hpi";
        sha256 = "53fc99c3ca6c2285e381455ddae7bac74a830b8c4103b1752f7c0d9778c0117b";
        };
      };
    mapdb-api = mkJenkinsPlugin {
      name = "mapdb-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/mapdb-api/1.0.9.0/mapdb-api.hpi";
        sha256 = "072c11a34cf21f87f9c44bf01b430c5ea77e8096d077e8533de654ef00f3f871";
        };
      };
    matrix-project = mkJenkinsPlugin {
      name = "matrix-project";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/matrix-project/1.19/matrix-project.hpi";
        sha256 = "c2a654a84f8c57bb810101cefca29223a35045f6aefae852501f8597449ea49f";
        };
      };
    maven-plugin = mkJenkinsPlugin {
      name = "maven-plugin";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/maven-plugin/3.12/maven-plugin.hpi";
        sha256 = "5463c9de1730855d66a501d6f8c6bf119f061cb1ebea4cbf70d67692894fbe1a";
        };
      };
    metrics = mkJenkinsPlugin {
      name = "metrics";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/metrics/4.0.2.8/metrics.hpi";
        sha256 = "a22469004f470aeabb9df145123a461e7e2f0e3710b6c9a14992ab8fcd281835";
        };
      };
    momentjs = mkJenkinsPlugin {
      name = "momentjs";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/momentjs/1.1.1/momentjs.hpi";
        sha256 = "ca3c2d264cff55f71e900dc7de1f13c0bfbffdb9b3419b854dce175bcb8a4848";
        };
      };
    nexus-jenkins-plugin = mkJenkinsPlugin {
      name = "nexus-jenkins-plugin";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/nexus-jenkins-plugin/3.11.20210811-095455.fdf8fec/nexus-jenkins-plugin.hpi";
        sha256 = "3dead40a592ad711d600f7652f110df8a22200805d7fdebdaa58e663049ffede";
        };
      };
    node-iterator-api = mkJenkinsPlugin {
      name = "node-iterator-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/node-iterator-api/1.5.0/node-iterator-api.hpi";
        sha256 = "531b04f2187a086e29963f3f4a9823b711b242eba2393ddf029038a5deb7df39";
        };
      };
    parameterized-trigger = mkJenkinsPlugin {
      name = "parameterized-trigger";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/parameterized-trigger/2.41/parameterized-trigger.hpi";
        sha256 = "29a6f937184c82b7db8da072396fd34e807cbfa311515d37c35bfe06da64b37c";
        };
      };
    pipeline-build-step = mkJenkinsPlugin {
      name = "pipeline-build-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-build-step/2.15/pipeline-build-step.hpi";
        sha256 = "36cd38d7223305aa66bb5baf8d9770f7af19085379fa6897cffb4f7907e22a0e";
        };
      };
    pipeline-graph-analysis = mkJenkinsPlugin {
      name = "pipeline-graph-analysis";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-graph-analysis/1.11/pipeline-graph-analysis.hpi";
        sha256 = "2a8965fabd0563832df74fe8a403d91a8828acafd4d972722e71fcce9abf64ce";
        };
      };
    pipeline-input-step = mkJenkinsPlugin {
      name = "pipeline-input-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-input-step/2.12/pipeline-input-step.hpi";
        sha256 = "eb82c943c09dbe4dcd57ea8ac43d33a68e544ca64620e5bcb433fdaf470a3bac";
        };
      };
    pipeline-milestone-step = mkJenkinsPlugin {
      name = "pipeline-milestone-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-milestone-step/1.3.2/pipeline-milestone-step.hpi";
        sha256 = "ac11055024e0173088875d7b2ec3f2f005076f8827492d56fbd7076aae19f590";
        };
      };
    pipeline-model-api = mkJenkinsPlugin {
      name = "pipeline-model-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-model-api/1.9.1/pipeline-model-api.hpi";
        sha256 = "a352d03c843dcfa02928de4cc493b50b3f22d838092d2f5d9b738bae3ae8349a";
        };
      };
    pipeline-model-definition = mkJenkinsPlugin {
      name = "pipeline-model-definition";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-model-definition/1.9.1/pipeline-model-definition.hpi";
        sha256 = "3a0684156cf4714a2c75d78809efcb349b832d64ee9ec7006a627e165cb15834";
        };
      };
    pipeline-model-extensions = mkJenkinsPlugin {
      name = "pipeline-model-extensions";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-model-extensions/1.9.1/pipeline-model-extensions.hpi";
        sha256 = "4b575292ea7588208d7530be18b12794309ebf10c9e2699f6ca4efe422ff511b";
        };
      };
    pipeline-rest-api = mkJenkinsPlugin {
      name = "pipeline-rest-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-rest-api/2.19/pipeline-rest-api.hpi";
        sha256 = "9388d4b3001828a7bcd0c00fdb24bde3183ac3d973a27cf65be50f9d1b1c3e89";
        };
      };
    pipeline-stage-step = mkJenkinsPlugin {
      name = "pipeline-stage-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-stage-step/2.5/pipeline-stage-step.hpi";
        sha256 = "a98f62174dbd6aa0ba978efb839f2f814f0acf4c4d264e7740aa3747bf6c6523";
        };
      };
    pipeline-stage-tags-metadata = mkJenkinsPlugin {
      name = "pipeline-stage-tags-metadata";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-stage-tags-metadata/1.9.1/pipeline-stage-tags-metadata.hpi";
        sha256 = "57c6ce69065264f538f683603e08b0016eb4a800792e14570efba9fbd48808cb";
        };
      };
    pipeline-stage-view = mkJenkinsPlugin {
      name = "pipeline-stage-view";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/pipeline-stage-view/2.19/pipeline-stage-view.hpi";
        sha256 = "5dee54199a33e8f959e4e35b8c265713b11768086d20a8c1dd596ddfe45297ce";
        };
      };
    plain-credentials = mkJenkinsPlugin {
      name = "plain-credentials";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/plain-credentials/1.7/plain-credentials.hpi";
        sha256 = "5a82ca66b397daccf663695b531fdf7ea993d5c1cb03f1b4692dbe804d163ba8";
        };
      };
    plugin-util-api = mkJenkinsPlugin {
      name = "plugin-util-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/plugin-util-api/2.4.0/plugin-util-api.hpi";
        sha256 = "8fe46dbbbcc2d7b8db3e1511196df5bba068204e4406b45942995a14a59d5b53";
        };
      };
    popper-api = mkJenkinsPlugin {
      name = "popper-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/popper-api/1.16.1-2/popper-api.hpi";
        sha256 = "c5bbf6279fa3492724e86376da2ecc038a27b089287012f6f11b50b6ab65e3f2";
        };
      };
    popper2-api = mkJenkinsPlugin {
      name = "popper2-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/popper2-api/2.9.3-1/popper2-api.hpi";
        sha256 = "5017ae84595bcb71d350575e163a0e07e4c01f75f96144c070523d2aca42e551";
        };
      };
    project-inheritance = mkJenkinsPlugin {
      name = "project-inheritance";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/project-inheritance/21.04.03/project-inheritance.hpi";
        sha256 = "c7e714d2a096ceb719f9a91eb61d12c6da1619f139254ce91db1ead58520ecf7";
        };
      };
    promoted-builds = mkJenkinsPlugin {
      name = "promoted-builds";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/promoted-builds/3.10/promoted-builds.hpi";
        sha256 = "1cc5f1a8d823cd9e009f6bec14ae285dab50d84a6e3547014b29d51533d967b9";
        };
      };
    rebuild = mkJenkinsPlugin {
      name = "rebuild";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/rebuild/1.32/rebuild.hpi";
        sha256 = "44f1091e9110c0f7137bc4cf2f80701d06474c18d0cf2e19e4c773a5f2c8841a";
        };
      };
    resource-disposer = mkJenkinsPlugin {
      name = "resource-disposer";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/resource-disposer/0.16/resource-disposer.hpi";
        sha256 = "fd924c8001799de12b0cae5dd86be230b27c581356ec9acf4c6ab4d0c842faaa";
        };
      };
    run-condition = mkJenkinsPlugin {
      name = "run-condition";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/run-condition/1.5/run-condition.hpi";
        sha256 = "7ed94d7196676c00e45b5bf7e191831eee0e49770dced1c266b8055980b339ca";
        };
      };
    scm-api = mkJenkinsPlugin {
      name = "scm-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/scm-api/2.6.5/scm-api.hpi";
        sha256 = "20adc461e6459098ffc538dace079d76b948f7ee6f86b247703720e803e2c840";
        };
      };
    script-security = mkJenkinsPlugin {
      name = "script-security";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/script-security/1.78/script-security.hpi";
        sha256 = "1254a2d2a9c44e76d7855582db458bbfd9e934338a44831eb230e9de4653a2db";
        };
      };
    slack = mkJenkinsPlugin {
      name = "slack";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/slack/2.48/slack.hpi";
        sha256 = "226f9cb22bb47c9461eef86bf616f8c9a8e0d62800ad56dd26032ca2f137d5e3";
        };
      };
    snakeyaml-api = mkJenkinsPlugin {
      name = "snakeyaml-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/snakeyaml-api/1.29.1/snakeyaml-api.hpi";
        sha256 = "9f8b34f1e657a4e88349663988b405e2dead6b1f9e737e8fac9736a69b6e5595";
        };
      };
    ssh-credentials = mkJenkinsPlugin {
      name = "ssh-credentials";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/ssh-credentials/1.19/ssh-credentials.hpi";
        sha256 = "6dc93c4ac8669d3851ea23b15d675b973f0c042658d2e8cbfa868eed8549ed15";
        };
      };
    ssh-slaves = mkJenkinsPlugin {
      name = "ssh-slaves";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/ssh-slaves/1.32.0/ssh-slaves.hpi";
        sha256 = "4d0cae5775989f0eec5342c8ed29cbf69d5e8c85c7125f62f702abebd638726f";
        };
      };
    sshd = mkJenkinsPlugin {
      name = "sshd";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/sshd/3.1.0/sshd.hpi";
        sha256 = "984c487264edfb6ad56837c01e9b2721032351318c9d4ff28946cdfe51f58714";
        };
      };
    structs = mkJenkinsPlugin {
      name = "structs";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/structs/1.23/structs.hpi";
        sha256 = "0d53d44b4ce7f887436921a81321f1738de7391a35912c1096fe412df4d6338a";
        };
      };
    subversion = mkJenkinsPlugin {
      name = "subversion";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/subversion/2.14.4/subversion.hpi";
        sha256 = "c628408794f214aa6874477ad33c91281bb198cbf0893ac8153420205e651417";
        };
      };
    support-core = mkJenkinsPlugin {
      name = "support-core";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/support-core/2.74/support-core.hpi";
        sha256 = "a255d239f45e1a056cc23d9bce218a1bef767a7a2c8b76f0df7dfccace1afc8e";
        };
      };
    token-macro = mkJenkinsPlugin {
      name = "token-macro";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/token-macro/266.v44a80cf277fd/token-macro.hpi";
        sha256 = "37852544f0b8b3f34b776a29b84f2c2a6d4e5a3828fdabf68cb7786a1a9c4b4f";
        };
      };
    trilead-api = mkJenkinsPlugin {
      name = "trilead-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/trilead-api/1.0.13/trilead-api.hpi";
        sha256 = "62b46838e493cfc6950382b4e4975d865cd3bfbfc58ada704b9dd96ff101e457";
        };
      };
    variant = mkJenkinsPlugin {
      name = "variant";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/variant/1.4/variant.hpi";
        sha256 = "4c2985249aa9223dd4471898b0fe16849f7b2a16bf05870544062174605b67f3";
        };
      };
    vsphere-cloud = mkJenkinsPlugin {
      name = "vsphere-cloud";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/vsphere-cloud/2.25/vsphere-cloud.hpi";
        sha256 = "34e371e66aa3a6d577b9359f1dbf147764b77e67691470e0432d6b45db081dd7";
        };
      };
    workflow-aggregator = mkJenkinsPlugin {
      name = "workflow-aggregator";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-aggregator/2.6/workflow-aggregator.hpi";
        sha256 = "bdcc467277e6e589853ef2d1dab9ca8cf6872017a306b6bf6223b9a90be24bf6";
        };
      };
    workflow-api = mkJenkinsPlugin {
      name = "workflow-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-api/2.46/workflow-api.hpi";
        sha256 = "50ef8934366ca61295113f5bd85303222cb8001049aa219934ac61b1f51bb507";
        };
      };
    workflow-basic-steps = mkJenkinsPlugin {
      name = "workflow-basic-steps";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-basic-steps/2.24/workflow-basic-steps.hpi";
        sha256 = "3cb39af3c0c8a83be7a6ff987901c04940cdf442e02ee44a15c99e829b510506";
        };
      };
    workflow-cps = mkJenkinsPlugin {
      name = "workflow-cps";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-cps/2.93/workflow-cps.hpi";
        sha256 = "86537fdb8444ff07f7f393ee49093add796c8cc6154f22ee98a1f7e79fb03b46";
        };
      };
    workflow-cps-global-lib = mkJenkinsPlugin {
      name = "workflow-cps-global-lib";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-cps-global-lib/2.21/workflow-cps-global-lib.hpi";
        sha256 = "33e2ef0b58d2ad054b6a190d925ec37380a4003c009b3448c38f74eb64d32f28";
        };
      };
    workflow-durable-task-step = mkJenkinsPlugin {
      name = "workflow-durable-task-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-durable-task-step/2.39/workflow-durable-task-step.hpi";
        sha256 = "c2cfa846ae0e4e0f50db77f18d7d84bf32b77576a5b2d05a151040a8565d8b55";
        };
      };
    workflow-job = mkJenkinsPlugin {
      name = "workflow-job";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-job/2.41/workflow-job.hpi";
        sha256 = "ef78d24ffb6b84bba5a31fb937f5cf22efd57a2a576d41cb61144f70ef6fe3d1";
        };
      };
    workflow-multibranch = mkJenkinsPlugin {
      name = "workflow-multibranch";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-multibranch/2.26/workflow-multibranch.hpi";
        sha256 = "c2d67f6902fe8741552b1cd4e8a69262f4b4bc1db8842d57b808310031100410";
        };
      };
    workflow-scm-step = mkJenkinsPlugin {
      name = "workflow-scm-step";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-scm-step/2.13/workflow-scm-step.hpi";
        sha256 = "6a97728795e3a77104760e5fca74d42c3d20755173675f706196ac142209c5e4";
        };
      };
    workflow-step-api = mkJenkinsPlugin {
      name = "workflow-step-api";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-step-api/2.24/workflow-step-api.hpi";
        sha256 = "e6d629ebdc248d2483069b5c67d1337df5ebc953600fbaed3b4d9e65dde34266";
        };
      };
    workflow-support = mkJenkinsPlugin {
      name = "workflow-support";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/workflow-support/3.8/workflow-support.hpi";
        sha256 = "e88769cb88a05277a2df8d8793bba34550f223e27161bfb44194c0918ec93138";
        };
      };
    ws-cleanup = mkJenkinsPlugin {
      name = "ws-cleanup";
      src = fetchurl {
        url = "https://updates.jenkins-ci.org/download/plugins/ws-cleanup/0.39/ws-cleanup.hpi";
        sha256 = "7bc8f0058aee2f25e15eaf31a2de1816d251de9953933a35c702b05f0016e4f3";
        };
      };
    }