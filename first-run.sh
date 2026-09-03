#/!usr/bin/env bash

nix --version
set -euo pipefail
FLAKE="${1:-.#darwin-home}"
nix run github:nix-community/home-manager/master -- switch --flake $FLAKE
