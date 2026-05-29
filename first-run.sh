#/!usr/bin/env bash

nix --version
nix run github:nix-community/home-manager/master -- switch --flake .#$(whoami)