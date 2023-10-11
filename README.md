## Developer environment setup
This directory is intended to help a developer setup their local environment with the right CLI tools & configurations.

## Dependencies
- [Make](https://www.gnu.org/software/make/)
- [Xcode](https://developer.apple.com/xcode/)

## Usage
### For Automatic installation
Run `curl -s https://raw.githubusercontent.com/nexxt-intelligence/build-harness/master/dev-setup/install.sh > install.sh && chmod +x install.sh &&bash ./install.sh && rm install.sh` in a terminal window in the directory of your choice.
### For Manual Installation
1. Clone the repository by running `git clone https://github.com/nexxt-intelligence/build-harness.git`
2. Navigate to the `dev-setup` directory by running `cd dev-setup`
3. Run `make help` to see the available commands
4. Run `make setup/full` to install all dependencies and setup the environment

## Commands
- `make install/rosetta` - Installs Rosetta 2 on Apple Silicon Macs & adds 2 aliases to the `.zshrc` file for easy switching between architectures.
- `make install/homebrew` - Installs [Homebrew](https://brew.sh/).
- `make install/packages` - Installs all CLI packages which are required to run most nexxt-intelligence projects.
- `make install/vscode-extensions` - Installs all the crucial VSCode extensions for nexxt-intelligence projects.
- `make setup/aws` - Sets up the AWS CLI for an environment by prompting the user for their AWS Access Key ID, AWS Secret Access Key, and default region.
- `make setup/full` - Installs all dependencies and sets up the environment.
