#!/usr/bin/env bash
set -euo pipefail
FLAKE="${1:-.#darwin-home}"
home-manager switch --flake "$FLAKE"
