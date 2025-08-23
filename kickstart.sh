#!/bin/bash

set -o errexit

script_dir=$(dirname "$(realpath "$0")")
download_dir="$script_dir/downloads"
mkdir -p "$download_dir"

# Updating packages
sudo apt update && sudo apt upgrade -y

# Installing CLI tools
sudo apt install -y tmux tree bat ripgrep fzf nodejs npm unzip luarocks lf \
    zoxide neofetch fd-find g++ gcc ranger git curl vim stow python3-pip python3-venv

# Installing zsh
if ! which zsh >/dev/null; then
    echo "Installing zsh"
    sudo apt install zsh -y
    chsh -s "$(which zsh)"
fi

# Installing oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm ~/.zshrc
fi

# Oh-my-zsh plugins
zsh_plugins_folder="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$zsh_plugins_folder/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_plugins_folder/plugins/zsh-autosuggestions"
fi
if [ ! -d "$zsh_plugins_folder/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$zsh_plugins_folder/themes/powerlevel10k"
fi

# Cool tools that I might consider later
# entr (executes commands on file change)
# logo-ls (ls with icons)
# btop (like htop with a cooler UI)
# zellij (like tmux, but more user friendly)
# httpie (improved curl)
# oathtool (otp on zsh plugin list)

# Install nerd font
# NOTE: It is likely that you will need to choose the font on the terminal settings
cd "$download_dir" || exit 1
if [ ! -f ~/.fonts/FiraCodeNerdFontMono-Regular.ttf ]; then
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf -P ~/.fonts
    fc-cache -fv ~/.fonts
fi
# if [ ! -f ~/.fonts/JetBrainsMonoNerdFontMono-Medium.ttf ]; then
# 	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
# 	unzip JetBrainsMono.zip -d ~/.fonts
# fi

# Install go
# TODO: Test installing go with apt golang-go
if ! which go >/dev/null; then
    echo "Installing golang"
    # sudo apt install -y golang-go
    cd "$download_dir" || exit 1
    curl -OL https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
fi
export PATH=$PATH:/usr/local/go/bin

# Install cargo
if ! which cargo >/dev/null; then
    echo "Installing cargo"
    cd "$download_dir" || exit 1
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

# Update node.js
sudo npm install n -g
sudo n stable

# Installing lazygit
if ! which lazygit >/dev/null; then
    echo "Installing lazygit"
    cd "$download_dir" || exit 1
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
fi

# Installing neovim
if ! which nvim >/dev/null; then
    echo "Installing neovim"
    neovim_dir="$download_dir/neovim"
    mkdir "$neovim_dir"
    cd "$neovim_dir" || exit 1
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
    tar xzvf nvim-linux-x86_64.tar.gz
    sudo ln -s "$neovim_dir/nvim-linux-x86_64/bin/nvim" /usr/local/bin
fi

# Install packages for neovim
sudo npm install -g neovim
sudo npm install -g sql-language-server

# tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install tools with go
if ! which lazydocker >/dev/null; then
    echo "Installing lazydocker"
    go install github.com/jesseduffield/lazydocker@latest
fi

# Install eza
if ! which eza >/dev/null; then
    echo "Installing eza"
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

# Install docker
if ! which docker >/dev/null; then
    echo "Installing docker"
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    OS_NAME=$(. /etc/os-release && echo "$NAME")
    if [ "$OS_NAME" == "Linux Mint" ]; then
        VERSION=$(. /etc/os-release && echo "$UBUNTU_CODENAME")
    elif [ "$OS_NAME" == "Ubuntu" ]; then
        VERSION=$(. /etc/os-release && echo "$VERSION_CODENAME")
    else
        echo "Invalid OS used: $OS_NAME"
        exit 1
    fi
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
        https://download.docker.com/linux/ubuntu $VERSION stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt update
    sleep 2
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    if ! getent group docker; then
        sudo groupadd docker
    fi
    sudo usermod -aG docker "$USER"
fi

sudo apt install -y python3-pynvim

# Use stow to sym-link my dotfiles
cd "$script_dir" || exit 1
echo "Stow-ing files"
stow -R stow_files
