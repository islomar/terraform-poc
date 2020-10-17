#!/bin/bash
set -euxo pipefail

docker run \
    --rm -it \
    -v $PWD/aws-nuke-config.yml:/home/aws-nuke/config.yml \
    -v /home/user/.aws:/home/aws-nuke/.aws \
    quay.io/rebuy/aws-nuke:v2.11.0 \
    --access-key-id <insert_here_your_access_key_id> \
    --secret-access-key <insert_here_your_secret_access_key> \
    --config /home/aws-nuke/config.yml \
    --no-dry-run
