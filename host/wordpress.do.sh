#!/bin/bash
set -euo pipefail

function source_file() {
  echo "$(readlink -f ${BASH_SOURCE[0]})"
}

function source_path() {
  echo "$(dirname $(source_file))"
}

function cli_command() {
  local image="docker.io/agrozyme/wordpress"
  local command="$(source_path)/docker.do.sh run_command -v ${PWD}:/var/www/html $@ ${image} "
  echo "${command}"
}

function wp() {
  local run="$(cli_command) wp $@"
  ${run}
}

function main() {
  local call=${1:-}

  if [[ -z $(typeset -F "${call}") ]]; then
    return
  fi

  shift
  ${call} "$@"
}

main "$@"
