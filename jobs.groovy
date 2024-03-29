groups = System.getenv("GITLAB_GROUPS").split(",")

def newFolder(String group) {
    organizationFolder(group) {
        description("https://gitlab.corp1.majordomo.ru/" + group)
        displayName(group)
        // "Projects"
        organizations {
            gitLabSCMNavigator {
                projectOwner(group)
                credentialsId("gitlab.intr")
                serverName("gitlab.corp1.majordomo.ru")
                // "Traits" ("Behaviours" in the GUI) that are "declarative-compatible"
                traits {
                    subGroupProjectDiscoveryTrait() // discover projects inside subgroups
                    gitLabBranchDiscovery {
                        strategyId(3) // discover all branches
                    }
                    originMergeRequestDiscoveryTrait {
                        strategyId(1) // discover MRs and merge them with target branch
                    }
                    projectNamingStrategyTrait {
                        // Configure job URLs.  For example, 'nixos' group
                        // 'jenkins' project 'master' branch will be:
                        // JENKINS_DOMAIN_NAME/job/nixos/job/jenkins/job/master/
                        strategyId(4)
                    }
                    gitLabTagDiscovery() // discover tags
                    // Configure SSH private key for Git clone, see
                    // https://github.com/jenkinsci/gitlab-branch-source-plugin/blob/317f76b071948dc264d3615a973616f2343afc95/src/main/java/io/jenkins/plugins/gitlabbranchsource/GitLabSCMBuilder.java#L110
                    credentialsId("jenkins-ssh-deploy")
                }
            }
        }
        // "Traits" ("Behaviours" in the GUI) that are NOT "declarative-compatible"
        // For some 'traits, we need to configure this stuff by hand until JobDSL handles it
        // https://issues.jenkins.io/browse/JENKINS-45504
        configure { node ->
            def traits = node / navigators / 'io.jenkins.plugins.gitlabbranchsource.GitLabSCMNavigator' / traits
            traits << 'io.jenkins.plugins.gitlabbranchsource.ForkMergeRequestDiscoveryTrait' {
                strategyId('2')
                trust(class: 'io.jenkins.plugins.gitlabbranchsource.ForkMergeRequestDiscoveryTrait$TrustPermission')
            }
        }
        // "Project Recognizers"
        projectFactories {
            workflowMultiBranchProjectFactory {
                scriptPath 'Jenkinsfile'
            }
        }
        // "Orphaned Item Strategy"
        orphanedItemStrategy {
            discardOldItems {
                daysToKeep(-1)
                numToKeep(-1)
            }
        }
        // "Scan Organization Folder Triggers" : 1 day
        // We need to configure this stuff by hand because JobDSL only allow 'periodic(int min)' for now
        configure { node ->
            node / triggers / 'com.cloudbees.hudson.plugins.folder.computed.PeriodicFolderTrigger' {
                spec('H H * * *')
                interval(86400000)
            }
        }
    }
}

groups.each { group -> newFolder(group) }
