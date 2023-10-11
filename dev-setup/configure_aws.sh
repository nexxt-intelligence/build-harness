#!/usr/bin/env bash

# A interactive simple script to optionally configure AWS CLI with profiles named, "nidev", "nistaging", and "niprod"

source ./dev-setup/check_install.sh
source ./dev-setup/util.sh

ENVIRONMENTS=("dev" "staging" "prod")
PROFILES=("nidev" "nistaging" "niprod")

# A funtion to check if a profile with the given name exists & ask the user if they want to overwrite it (yes/no) & return true/false
function check_profile_exists() {
    # Check if the profile already exists, 
    if aws configure list-profiles | grep -q "$1"; then
        color_echo "warn" "Profile $1 already exists"
        aws configure list --profile "$1"
        color_echo "info" "Would you like to overwrite it? (yes/no)"
        select_option "yes" "no"
        local overwrite_profile=$?
        if [ $overwrite_profile -eq 0 ]; then
            return 0
        else
            return 1
        fi
    else
        return 0
    fi
}

# A function to ask the user which profile to configure and then configure it
function configure_profile() {
    check_install_homebrew
    check_install_package "aws"
    color_echo "info" "Configuring profile $1"
    
    # Check if the profile already exists, if we get a 0 then proceed to configure the profile, else exit
    check_profile_exists "$1"
    local profile_exists=$?
    if [ $profile_exists -eq 0 ]; then
        aws configure --profile "$1"
        color_echo "success" "Profile $1 configured successfully"
    else
        color_echo "warn" "Exiting..."
        exit 1
    fi
}

# A interactive function to ask the user which environment they want to configure & then configure the profile for that environment
function configure_environment() {
    color_echo "info" "Which environment would you like to configure?"

    # Ask the user to select an environment using select_option function defined in utils.sh & store the result in a variable
    select_option "${ENVIRONMENTS[@]}"
    local selected_environment=$?

    color_echo "info" "You selected ${ENVIRONMENTS[$selected_environment]}"

    configure_profile "${PROFILES[$selected_environment]}"
}

# execute the configure_environment function
configure_environment