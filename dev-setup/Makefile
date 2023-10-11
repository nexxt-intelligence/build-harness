# Makefile to setup a full development environment on macOS.

# -include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/nexxt-intelligence/build-harness/master/templates/Makefile.build-harness"; echo .build-harness)

# A list of standard vscode extensions to support the development environment
VSCODE_EXTENSIONS := dsznajder.es7-react-js-snippets github.vscode-github-actions GitHub.vscode-pull-request-github hashicorp.terraform hediet.vscode-drawio mongodb.mongodb-vscode ms-azuretools.vscode-docker ms-mssql.data-workspace-vscode ms-mssql.mssql ms-mssql.sql-bindings-vscode ms-mssql.sql-database-projects-vscode ms-python.python ms-python.vscode-pylance ms-toolsai.jupyter ms-toolsai.jupyter-keymap ms-toolsai.jupyter-renderers ms-toolsai.vscode-jupyter-cell-tags ms-toolsai.vscode-jupyter-slideshow ms-vscode.cmake-tools ms-vscode.cpptools ms-vscode.cpptools-extension-pack ms-vscode.cpptools-themes ms-vscode.makefile-tools twxs.cmake

define find.functions
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
endef

help: ## List all commands.
	@printf "Usage: make [target]\n\n"
	@printf "Targets:\n"
	@$(call find.functions)

install/rosetta:## Enable Rosetta 2 on Apple Silicon to run x86_64 binaries.
	@printf "Enabling Rosetta 2...\n"
	@sudo softwareupdate --install-rosetta --agree-to-license
	@printf "Rosetta 2 enabled.\n"
	@printf "Adding aliases to current user's .zshrc file...\n"
	@printf "alias arm='$env /usr/bin/arch -arm64 /bin/zsh'\n" >> ~/.zshrc
	@printf "alias intel='$env /usr/bin/arch -x86_64 /bin/zsh'\n" >> ~/.zshrc
	@printf "Two aliases have been added to your .zshrc file.\n Run arm to use the Apple Silicon version of a command and intel to use the x86_64 version of a command.\n To see which architecture a command is using, run arch.\n"

install/homebrew:## Install Homebrew.
	@printf "Installing Homebrew...\n"
	@bash ./check_install_homebrew.sh

install/packages:## Install all cli packages required for development.
	@printf "Installing packages...\n"
	@bash ./install_packages.sh
	@bash ./install_packages_cask.sh

install/vscode-extensions:## Install all the crucial VSCode extensions.
	@printf "Installing VSCode extensions...\n"
	@bash ./check_install_vscode.sh
	@for extension in $(VSCODE_EXTENSIONS); do \
		printf "Installing $$extension...\n"; \
		code --install-extension $$extension; \
	done
	@printf "All VSCode extensions are installed.\n"

setup/aws:## Setup AWS credentials.
	@bash ./configure_aws.sh

setup/full:## Do a full setup of the development environment (install packages, install VSCode extensions, etc.).
	$(MAKE) install/packages
	$(MAKE) install/vscode-extensions
	$(MAKE) setup/aws