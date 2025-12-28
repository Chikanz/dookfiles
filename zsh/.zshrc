# Display random script fact on login
function random_script_fact() {
  local descriptions_file="$HOME/dookfiles/zsh/.bin-descriptions"
  if [[ -f "$descriptions_file" ]]; then
    # Get all non-comment, non-empty lines into an array
    local facts=()
    while IFS= read -r line; do
      facts+=("$line")
    done < <(grep -v '^#' "$descriptions_file" | grep -v '^$')

    if [[ ${#facts[@]} -gt 0 ]]; then
      # Select random fact
      local random_fact=${facts[$RANDOM % ${#facts[@]}]}
      # Split on : and format nicely
      local script_name="${random_fact%%:*}"
      local description="${random_fact#*:}"
      echo "💡 \033[1;36m$script_name\033[0m - $description"
    fi
  fi
}

random_script_fact
# source /Users/dook/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10   k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# macOS: Cache brew prefix for performance (avoid calling brew --prefix multiple times)
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &> /dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  # GNU utilities (prioritize GNU versions over macOS defaults)
  export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gnu-which/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
  export PATH="$BREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Lazy load nvm to speed up startup time:
export NVM_LAZY_LOAD=true
source "${HOME}/.zsh-nvm.plugin.zsh"

# iTerm2 shell integration (if installed)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(zoxide init --cmd cd zsh)"
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Created by `pipx` on 2024-07-24 13:01:28
export PATH="$PATH:$HOME/.local/bin"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Deno environment (if installed)
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# Initialize zsh completions (added by deno install script)
# Only regenerate compdump once a day for faster startup
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C  # Skip security checks (faster)
fi

# Update settings
UPDATE_ZSH_DAYS=30
DISABLE_UPDATE_PROMPT=true

# macOS-specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias wstorm='open -na "WebStorm.app" --args "$@"'
fi

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias mdkir='mkdir'
alias dc='cd'
alias sl='ls'
alias sudp='sudo'

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}


# Machine-specific configuration (not tracked in git)
# Create ~/.zshrc.local for machine-specific settings like:
#   - Custom PATH additions (e.g., postgresql, mongodb, python versions)
#   - Machine-specific aliases (e.g., IDE launchers)
#   - Environment variables that differ per machine
# See ~/.dotfiles/zsh/.zshrc.local.example for examples
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"