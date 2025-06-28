#!/usr/bin/env bash
set -euox pipefail

echo Hi
protoc --version
javac --version

javac Hello.java
java Hello

# Bat is not in the Nix devShell, so this will fail:
# bat --version
