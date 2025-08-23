#!/bin/bash

set -o errexit

script_dir=$(dirname "$(realpath "$0")")
download_dir="$script_dir/downloads"
mkdir -p "$download_dir"


function install_brew_package() {
    command_name="$1"
    package_name="$2"
    if ! which "$command_name" >/dev/null; then
        echo "Installing $package_name"
        brew install "$package_name"
    else
        echo "$package_name is already installed"
    fi
}

# Install homebrew
if ! which brew >/dev/null; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Installing zsh
if ! which zsh >/dev/null; then
    echo "Installing zsh"
    brew install zsh
    chsh -s "$(which zsh)"
fi

# Installing oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm ~/.zshrc
fi

# Oh-my-zsh plugins
# zsh_plugins_folder="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
# if [ ! -d "$zsh_plugins_folder/plugins/zsh-autosuggestions" ]; then
#     echo "Installing zsh-autosuggestions"
#     git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_plugins_folder/plugins/zsh-autosuggestions"
# fi
# if [ ! -d "$zsh_plugins_folder/themes/powerlevel10k" ]; then
#     echo "Installing powerlevel10k"
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$zsh_plugins_folder/themes/powerlevel10k"
# fi

# Install go
install_brew_package "go" "go"
export PATH=$PATH:/usr/local/go/bin

# Install cargo
if ! which cargo >/dev/null; then
    echo "Installing cargo"
    cd "$download_dir" || exit 1
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

install_brew_package "nvim" "neovim"
install_brew_package "lazygit" "lazygit"
install_brew_package "tmux" "tmux"

# Update node.js
sudo npm install n -g
sudo n stable
# Install packages for neovim
sudo npm install -g neovim
sudo npm install -g sql-language-server

# tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

install_brew_package "eza" "eza"
install_brew_package "docker" "docker"
install_brew_package "stow" "stow"

if ! which uv >/dev/null; then
    echo "Installing uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! pip show pynvim >/dev/null; then
    echo "Installing pynvim"
    pip install pynvim
fi

install_brew_package "fzf" "fzf"
install_brew_package "fd" "fd"
install_brew_package "bat" "bat"
install_brew_package "luarocks" "luarocks"
install_brew_package "rg" "ripgrep"


# Use stow to sym-link my dotfiles
cd "$script_dir" || exit 1
echo "Stow-ing files"
stow -R stow_files
