#!/bin/bash

function main() {
  local source="$(readlink -f ${BASH_SOURCE[0]})"
  local path="$(dirname ${source})"
  local wordpress_do="${path}/wordpress.do.sh"

  sudo chmod +x "${path}"/*
  alias profile="source ${source}"

  alias php="${wordpress_do} php"
  alias composer="${wordpress_do} composer"
  alias wp="${wordpress_do} wp"
}

main "$@"
