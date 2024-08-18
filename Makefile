# Target directory to install all the configuration to.
TARGET ?= ${HOME}

.DEFAULT: help

.PHONY: help
## Show help
help:
	@grep -B1 -E "^[a-zA-Z0-9_-]+\:" Makefile \
     | grep -v -- -- \
     | sed 'N;s/\n/###/' \
     | sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
     | column -t  -s '###'

.PHONY: add-nvim-conf
#: Symlink nvim-conf
add-nvim-conf:
	ln -s $$(pwd)/nvim $(TARGET)/.config/nvim

.PHONY: add-hack-fonts
#: Symlink nvim-conf
add-hack-fonts:
	mkdir ~/.local/share/fonts
	curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
	unzip Hack.zip -d ~/.local/share/fonts
	rm  -y Hack.zip
	fc-cache -f -v

.PHONY: add-wl-clipboard
#: add clipboard provider for wayland
add-wl-clipboard:
	sudo apt install wl-clipboard

.PHONY: add-python-provider
#: add pynvim python provider package and python dependency
add-python-provider:
	python3 -m pip install --user --upgrade pynvim --break-system-packages
	python3 -m pip install ruff-lsp --break-system-packages
	sudo apt install python3-venv

.PHONY: add-node-provider
#: add node provider
add-node-provider:
	npm install -g neovim
	yarn global add neovim

.PHONY: add-nvm
#: add node provider
add-nvm:
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

.PHONY: install
#: Install everything
install:  add-nvim-conf
	@echo Making $@…

.PHONY: add-dependency
#: Install dependency
install: add-hack-fonts add-wl-clipboard add-python-provider add-nvm
	@echo Making $@…
