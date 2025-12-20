# Brewfile for dotfiles dependencies
# Install with: brew bundle --file=~/.dotfiles/Brewfile

# Taps
tap "homebrew/bundle"

# Shell
brew "zsh"                              # Z shell
brew "bash"                             # Bash shell

# Shell enhancements
brew "zsh-autosuggestions"              # Fish-like autosuggestions for zsh
brew "powerlevel10k"                    # Powerlevel10k theme for zsh
brew "fzf"                              # Fuzzy finder

# Navigation & search
brew "zoxide"                           # Smarter cd command

# Version control
brew "git"                              # Version control system
brew "stow"                             # Symlink farm manager for dotfiles

# Programming languages & runtimes
brew "python@3.10"                      # Python 3.10
brew "node"                             # Node.js (alternative to nvm)
brew "deno"                             # Deno runtime
brew "bun"                              # Bun JavaScript runtime

# Package managers
brew "pipx"                             # Install Python applications in isolated environments
brew "nvm"                              # Node Version Manager

# Databases
brew "postgresql@17"                    # PostgreSQL 17

# Utilities
brew "wget"                             # Internet file retriever
brew "vim"                              # Vi IMproved text editor

# macOS-specific applications (casks)
# These will be skipped on Linux systems
if OS.mac?
  # Add any macOS-specific casks here if needed
  # cask "iterm2"
end
