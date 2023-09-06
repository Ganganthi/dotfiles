#!/bin/bash

# Updating packages
sudo apt update && sudo apt upgrade -y

# Installing zsh
sudo apt install zsh -y
chsh -s $(which zsh)

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Installing CLI tools
sudo apt install -y tmux exa tree bat ripgrep fzf \
	zoxide neofetch fd-find g++ gcc

cd ~
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Cool tools that I might consider later
# mc (file manager)
# ranger (file manager)
# entr (executes commands on file change)
# logo-ls (ls with icons)
# btop (like htop with a cooler UI)
# zellij (like tmux, but more user friendly)
# httpie (improved curl)
# oathtool (otp on zsh plugin list)

# Installing neovim
mkdir ~/neovim
cd ~/neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz 
tar xzvf nvim-linux64.tar.gz
sudo ln -s ~/neovim/nvim-linux64/bin/nvim /usr/local/bin
