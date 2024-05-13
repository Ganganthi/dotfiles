#!/bin/bash

# Updating packages
sudo apt update && sudo apt upgrade -y

# Installing zsh
sudo apt install zsh -y
chsh -s $(which zsh)

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm ~/.zshrc

# Oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Installing CLI tools
sudo apt install -y tmux exa tree bat ripgrep fzf nodejs npm unzip \
	zoxide neofetch fd-find g++ gcc ranger git curl vim stow python3-pip python3-venv \
	luarocks

# Cool tools that I might consider later
# entr (executes commands on file change)
# logo-ls (ls with icons)
# btop (like htop with a cooler UI)
# zellij (like tmux, but more user friendly)
# httpie (improved curl)
# oathtool (otp on zsh plugin list)

# Install nerd font
cd ~
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf -P ~/.fonts
fc-cache -fv ~/.fonts
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
# unzip JetBrainsMono.zip -d ~/.fonts

# Install go
# TODO: Test installing go with apt golang-go
cd ~
curl -OL https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz

# Install cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Update node.js
sudo npm install n -g
sudo n stable

# Installing lazygit
cd ~
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Installing neovim
mkdir ~/neovim
cd ~/neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
sudo ln -s ~/neovim/nvim-linux64/bin/nvim /usr/local/bin

# Install packages for neovim
pip3 install pynvim
npm install -g neovim

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Use stow to sym-link my dotfiles
# NOTE: Run this from the same folder as the script!
stow -R stow_files
