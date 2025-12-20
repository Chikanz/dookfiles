# Brewfile for dotfiles dependencies
# Install with: brew bundle --file=~/.dotfiles/Brewfile

# Taps
tap "homebrew/bundle"

# Shell
brew "zsh"                              # Z shell

# Shell enhancements
brew "zsh-autosuggestions"              # Fish-like autosuggestions for zsh
brew "powerlevel10k"                    # Powerlevel10k theme for zsh
brew "fzf"                              # Fuzzy finder

# GNU utilities (better versions of macOS defaults)
brew "coreutils"                        # GNU core utilities
brew "grep"                             # GNU grep
brew "gnu-sed"                          # GNU sed
brew "gnu-tar"                          # GNU tar
brew "gnu-which"                        # GNU which
brew "gawk"                             # GNU awk
brew "findutils"                        # GNU find, xargs, locate

# Navigation & search
brew "zoxide"                           # Smarter cd command

# Version control
brew "stow"                             # Symlink farm manager for dotfiles

# Programming languages & runtimes
brew "bun"                              # Bun JavaScript runtime

# macOS-specific applications (casks)
# These will be skipped on Linux systems
if OS.mac?
  # Add any macOS-specific casks here if needed
  # cask "iterm2"
end
