#!/usr/bin/env bash

# Merge the base.config file and the local config for this machine for i3wm

function main() {
  cat base.config `hostname`.config > config
  echo 'i3 config prepared'
}

main
