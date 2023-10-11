#!/usr/bin/env bash

# Import check_install.sh so we can use the functions defined there
source ./dev-setup/check_install.sh
source ./dev-setup/util.sh

# A list of all the packages to check for and install if not found
PACKAGES=(
    "git"
    "gh"
    "curl"
    "wget"
    "tmux"
    "pip3"
    "python3"
    "tfswitch"
    "aws"
    "sam"
    "terraform"
    "docker"
    "docker-compose"
    "kubectl"
    "gcc"
    "cmake"
    "node"
    "npm"
    "yarn"
)

check_install_homebrew

# Install all the packages
for package in "${PACKAGES[@]}"; do
    check_install_package "$package"
done