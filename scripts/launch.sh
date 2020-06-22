#!/bin/bash

set -ex

export fly_target=${fly_target:-main}
echo "Concourse API target ${fly_target}"

PIPELINE_DIR="pipelines"

pipeline="$1"
job="$2"

bin/fly -t ${fly_target} sp -p $1 -c "$PIPELINE_DIR/$1/$1.yml" -n
bin/fly -t ${fly_target} up -p $1
bin/fly -t ${fly_target} trigger-job -j "$1/$2" -w