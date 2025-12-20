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

### Prerequisites

Install GNU Stow:
```bash
# macOS
brew install stow

# Ubuntu/Debian
sudo apt install stow
```

### Setup on a new machine

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
