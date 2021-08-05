#!/bin/bash
set -e

# Set up ssh known hosts and agent
ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"

# split single parameter of this script into multiple params for the command
eval "set -- $1"
git-filter-repo "$@"

force_push_arg=
if [[ "$FORCE_PUSH" == "true" ]]; then force_push_arg="-f"; fi

#git push ${${FORCE_PUSH/#true/-f}/[^-][^f]*/} "git@github.com:$TARGET_ORG/$TARGET_REPO.git" HEAD:"$TARGET_BRANCH"
git push $force_push_arg "git@github.com:$TARGET_ORG/$TARGET_REPO.git" HEAD:"$TARGET_BRANCH"
