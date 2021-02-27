#!/bin/bash

# exit when command fails
set -o errexit
# exit when variable not set
set -o nounset
# print every instruction before executing it
#set -o xtrace

# Verbose enabled
VERBOSE=0
VERSION=0.0.1
POSITIONAL=() 

config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

######################### Functions ###########################################

Help()
{
    # Display help
    echo "Script to help update the different branches of config files"
    echo
    echo "Syntax: config-update [-h] [-v] branch"
    echo "options:"
    echo "h     Print this help."
    echo "v     Verbose mode."
    echo
}

color()
{
    "$@" 2>&1 >(while read line; do echo -e "\e[01;31m$line\e[0m" 1>&2; done)
}

branch_status() {
    local a=$1 b=${BRANCH}
    local base=$( ${config} merge-base $a $b )
    local aref=$( ${config} rev-parse  $a )
    local bref=$( ${config} rev-parse  $b )

    if [[ $aref == "$bref" ]]; then
        echo up-to-date
    elif [[ $aref == "$base" ]]; then
        echo behind
    elif [[ $bref == "$base" ]]; then
        echo ahead
    else
        echo diverged
    fi
}

################################ START ########################################

# Process input options
while [[ $# -gt 0 ]] 
do
    key="$1"

    case $key in
        -v)
            VERBOSE=1
            shift
            ;;
        -V|--version)
            echo ${VERSION}
            exit 0
            ;;
        -h|--help)
            Help
            exit 0
            ;;
        *)
            POSITIONAL+=($key)
            shift
            ;;
    esac
done

# exit if positional is unset
if [[ ${#POSITIONAL[@]} -gt 1 ]]; then
    echo "Excess arguments specified"
    Help
elif [[ ${#POSITIONAL[@]} -gt 0 ]]; then
    #echo ${POSITIONAL}
    BRANCH=${POSITIONAL[0]}
else
    echo "No branch specified, check help."
fi

# check if branch exists
branches="${config} branch --all"

if [[ $(${branches} | grep -w ${BRANCH} | wc -l) != "1" ]]; then
    Color "Your config managing repository does not contain the branch: ${BRANCH}."
fi

# Save current branch
CURRENT_BRANCH=$(${config} symbolic-ref --short -q HEAD)

# Stash changes
${config} stash

if [[ ${BRANCH} != "master" ]]; then
    # switch to specified branch,
    ${config} checkout ${BRANCH}

    # Pull changes from given branch
    ${config} pull origin ${BRANCH}
fi

# Checkout master
${config} checkout master

# Pull from master
${config} pull origin master

# Now we need to check if there are changes in master that need to be
# incorporated into the given branch
if [[ $(branch_status "master") == "ahead" ]]; then
    # check out given branch
    ${config} checkout ${BRANCH}
    # merge master into it
    ${config} merge master
fi

# Pop changes
${config} stash pop

# Commit
${config} commit

# Push
${config} push origin ${BRANCH}

# Switch back
${config} checkout ${CURRENT_BRANCH}

