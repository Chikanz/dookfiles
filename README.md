# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

This repository uses GNU Stow to manage dotfiles. Each subdirectory is a "package" that mirrors the structure of your home directory:

- `zsh/` - ZSH configuration (.zshrc, .zprofile, .zshenv, .p10k.zsh)
- `bash/` - Bash configuration (.bashrc)
- `git/` - Git configuration (.gitconfig, .gitignore_global)
- `fzf/` - FZF configuration (.fzf.bash, .fzf.zsh)
- `npm/` - NPM configuration (.npmrc)
- `iterm2/` - iTerm2 shell integration

## Installation

### Quick Start (Recommended)

For a fresh machine, use the automated bootstrap script:

```bash
# Clone this repository
git clone <your-repo-url> ~/.dotfiles

# Run the bootstrap script
cd ~/.dotfiles
./bootstrap.sh
```

The bootstrap script will:
- Install Homebrew (if not installed)
- Install all Brewfile dependencies
- Install Oh My Zsh
- Install Powerlevel10k theme
- Install zsh-autosuggestions plugin
- Install NVM (Node Version Manager)
- Install Deno
- Backup existing dotfiles
- Setup stow for all packages
- Set Zsh as default shell

### Manual Installation

#### Prerequisites

Install Homebrew (if not already installed):
```bash
# macOS and Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install Dependencies

Install all required dependencies using the Brewfile:
```bash
cd ~/.dotfiles
brew bundle
```

This will install:
- Shell tools (zsh, zsh-autosuggestions, powerlevel10k)
- Navigation tools (fzf, zoxide)
- Development tools (stow)
- Programming languages (bun)

#### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Install Powerlevel10k theme

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### Install zsh-autosuggestions plugin

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### Setup on a new machine

1. Clone this repository:
```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

2. Install all packages:
```bash
stow */
```

Or install specific packages:
```bash
stow zsh
stow git
stow fzf
```

## Usage

### Install a package
Create symlinks for a package (e.g., zsh):
```bash
cd ~/.dotfiles
stow zsh
```

### Uninstall a package
Remove symlinks for a package:
```bash
cd ~/.dotfiles
stow -D zsh
```

### Reinstall a package
Useful after making changes:
```bash
cd ~/.dotfiles
stow -R zsh
```

### Install all packages
```bash
cd ~/.dotfiles
stow */
```

## How it works

Stow creates symlinks from the package directories to your home directory. For example:
- `~/.dotfiles/zsh/.zshrc` → `~/.zshrc`
- `~/.dotfiles/git/.gitconfig` → `~/.gitconfig`

This allows you to keep all your dotfiles in one repository while maintaining them in their expected locations.

## Making changes

1. Edit files in the package directories (e.g., `~/.dotfiles/zsh/.zshrc`)
2. Changes are automatically reflected in your home directory (via symlinks)
3. Commit and push changes:
```bash
cd ~/.dotfiles
git add .
git commit -m "Update configuration"
git push
```

## Notes

- The original dotfiles in your home directory should be removed before stowing (Stow will warn you if they exist)
- After stowing, your dotfiles become symlinks to the repository
- Edit the symlinked files directly or edit them in the `.dotfiles` directory - they're the same file
