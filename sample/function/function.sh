#!/bin/bash

set -euo pipefail

function apply() {
  EVENT_DATA=$1
  echo "$EVENT_DATA" 1>&2;
  # only /tmp dir is writable
  cp -r /var/task/* /tmp/ && cd /tmp
  terraform init -input=false 1>&2 && terraform apply -input=false -auto-approve 1>&2
}
