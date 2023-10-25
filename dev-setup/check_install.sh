#!/usr/bin/env bash

# A map for the formulae of all the values in PACKAGES
# This to support bash < 4.0
PACKAGES_FORMULAE=(
    "git:git"
    "gh:github/gh/gh"
    "curl:curl"
    "wget:wget"
    "tmux:tmux"
    "pip3:python3"
    "python3:python3"
    "tfswitch:warrensbox/tap/tfswitch"
    "aws:awscli"
    "sam:aws-sam-cli"
    "terraform:terraform"
    "docker:docker"
    "docker-compose:docker-compose"
    "docker-machine:docker-machine"
    "kubectl:kubectl"
    "gcc:gcc"
    "cmake:cmake"
    "node:node"
    "npm:npm"
    "yarn:yarn"
    "terraform-docs:terraform-docs"
)

# A map for the formulae of all the values in CASK_PACKAGES
CASK_PACKAGES=(
    "conda:miniconda"
    "code:visual-studio-code"
)

# Find the formulae of a package from the list of PACKAGES_FORMULAE
function find_package_formulae () {
    # Loop through the array
    for i in "${PACKAGES_FORMULAE[@]}"; do
        # Split the key-value pair by :
        IFS=':' read -ra KV <<< "$i"
        # Check if the key matches the second argument
        if [[ "${KV[0]}" == "$1" ]]; then
            # Return the value
            echo "${KV[1]}"
            return
        fi
    done
}

# Find the formulae of a package from the list of CASK_PACKAGES
function find_cask_package_formulae () {
    # Loop through the array
    for i in "${CASK_PACKAGES[@]}"; do
        # Split the key-value pair by :
        IFS=':' read -ra KV <<< "$i"
        # Check if the key matches the second argument
        if [[ "${KV[0]}" == "$1" ]]; then
            # Return the value
            echo "${KV[1]}"
            return
        fi
    done
}

# Export a function to check if Homebrew is installed and install it if not.
# This is used in dev-setup/install_packages.sh
# This is used in dev-setup/install_packages_cask.sh
function check_install_homebrew() {
    if ! command -v brew &> /dev/null; then
        color_echo "error" "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        color_echo "info2" "Homebrew found."
    fi
}

# Export a function to check if a package is installed and install it if not.
# This is used in dev-setup/install_packages.sh
function check_install_package() {
    if ! command -v "$1" &> /dev/null; then
        formulae=$(find_package_formulae "$1")

        color_echo "warn" "$1 not found. Installing $formulae..."
        
        brew install "$formulae"
        
        color_echo "success" "$1 installed successfully"
    else
        color_echo "info2" "$1 already installed."
    fi
}

# Export a function to check if a package is installed and install it if not.
# This is used in dev-setup/install_packages_cask.sh
function check_install_cask_package() {
    if ! command -v "$1" &> /dev/null; then
        formulae=$(find_cask_package_formulae "$1")
        
        color_echo "warn" "$1 not found. Installing $formulae..."
        
        brew install --cask "$formulae"
        
        color_echo "success" "$1 installed successfully"
    else
        color_echo "info2" "$1 already installed."
    fi
}