#!/usr/bin/env bash

NIX_AUTO_RUN=1
export NIX_AUTO_RUN

alias s='sudo -i'

active_hms()
{
    if [[ -z JENKINS_PASSWORD ]]
    then
        printf "You should specify password in JENKINS_PASSWORD environment variable.\n"
        exit 1
    else
        curl -s --user "${JENKINS_USER:-jenkins}":"JENKINS_PASSWORD" nginx{1,2}-mr:8080/hms | jq -r .active | uniq "$@"
    fi
}

alias rr="system deploy"

nix-version()
{
    nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version';
}
