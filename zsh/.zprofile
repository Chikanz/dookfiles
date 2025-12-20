
# Initialize Homebrew (detect location for macOS and Linux)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # macOS Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  # macOS Intel
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  # Linux (system-wide)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f "$HOME/.linuxbrew/bin/brew" ]]; then
  # Linux (user install)
  eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# Created by `pipx` on 2024-07-24 13:01:28
export PATH="$PATH:$HOME/.local/bin"
