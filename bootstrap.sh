#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_info "Starting dotfiles bootstrap process..."
print_info "Dotfiles directory: $DOTFILES_DIR"

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    IS_MAC=true
else
    IS_MAC=false
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ "$IS_MAC" == true && -d "/opt/homebrew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Update Homebrew
print_info "Updating Homebrew..."
brew update

# Install dependencies from Brewfile
print_info "Installing dependencies from Brewfile..."
cd "$DOTFILES_DIR"
brew bundle --file="$DOTFILES_DIR/Brewfile"
print_success "Brewfile dependencies installed"

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# Install Powerlevel10k as Oh My Zsh custom theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_info "Installing Powerlevel10k theme for Oh My Zsh..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    print_success "Powerlevel10k theme installed"
else
    print_success "Powerlevel10k theme already installed"
fi

# Install zsh-autosuggestions as Oh My Zsh plugin
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    print_info "Installing zsh-autosuggestions plugin for Oh My Zsh..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_success "zsh-autosuggestions plugin installed"
else
    print_success "zsh-autosuggestions plugin already installed"
fi


# Backup existing dotfiles
print_info "Backing up existing dotfiles..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# List of files that might conflict
DOTFILES=(".zshrc" ".zshenv" ".zprofile" ".p10k.zsh" ".bashrc" ".gitconfig" ".gitignore_global" ".fzf.zsh" ".fzf.bash" ".iterm2_shell_integration.zsh")

for file in "${DOTFILES[@]}"; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        print_warning "Backing up existing $file"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi
done

if [ -d "$HOME/bin" ] && [ ! -L "$HOME/bin" ]; then
    print_warning "Backing up existing bin directory"
    mv "$HOME/bin" "$BACKUP_DIR/"
fi

# Show backup location if anything was backed up
if [ "$(ls -A $BACKUP_DIR)" ]; then
    print_success "Existing dotfiles backed up to: $BACKUP_DIR"
else
    rmdir "$BACKUP_DIR"
fi

# Setup stow for all packages
print_info "Setting up stow for dotfiles packages..."
cd "$DOTFILES_DIR"

# Get list of directories (packages) to stow, excluding hidden dirs and non-stow dirs
PACKAGES=()
for dir in "$DOTFILES_DIR"/*/; do
    dirname=$(basename "$dir")
    # Skip hidden directories, .git, .idea, and other non-package directories
    if [[ ! "$dirname" =~ ^\. ]]; then
        PACKAGES+=("$dirname")
    fi
done

# Stow each package
for package in "${PACKAGES[@]}"; do
    print_info "Stowing $package..."
    stow -v "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
done

print_success "All packages stowed successfully"

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Setting Zsh as default shell..."
    if [[ "$IS_MAC" == true ]]; then
        # Add Homebrew zsh to allowed shells if not present
        if ! grep -q "$(which zsh)" /etc/shells; then
            print_warning "Adding Homebrew zsh to /etc/shells (requires sudo)"
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
    fi
    chsh -s "$(which zsh)"
    print_success "Zsh set as default shell"
else
    print_success "Zsh already set as default shell"
fi

# Install fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
    print_info "Installing fzf key bindings and completion..."
    if [[ "$IS_MAC" == true ]]; then
        "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
    else
        /usr/bin/fzf/install --key-bindings --completion --no-update-rc
    fi
    print_success "fzf key bindings and completion installed"
fi

# Final instructions
echo ""
print_success "Bootstrap complete!"
echo ""
print_info "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. If this is your first time with Powerlevel10k, run: p10k configure"
echo ""
print_warning "Note: Your original dotfiles have been backed up to $BACKUP_DIR (if any existed)"
