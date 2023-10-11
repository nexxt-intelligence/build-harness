#!/usr/bin/env bash

# Import check_install.sh so we can use the functions defined there
source ./dev-setup/check_install.sh
source ./dev-setup/util.sh

# A list of all the packages to install
PACKAGES=(
    "conda"
    "code"
)

# check_install_homebrew

# Install all the packages
for package in "${PACKAGES[@]}"; do
    check_install_cask_package "$package"
done