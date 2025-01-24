# Function to run neofetch if not insight tmux or neovim
if ! ([ -n "$TMUX" ] || [ -n "$NVIM" ] || [ "$TTY" = "/dev/tty1" ] || [ "$TERM" = "linux" ]); then
  fastfetch
fi

export PATH=$PATH:/home/nerd/.local/bin
export PATH=$PATH:/home/nerdninja420/.local/share:/home/nerdninja420/.local/bin:/snap/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$PATH:/home/nerd/.cargo/bin
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# vi mode if not insight nvim or tmux
if ! ([ -n "$NVIM" ]); then
  zinit ice depth=1
  zinit light Aloxaf/fzf-tab
  zinit light jeffreytse/zsh-vi-mode
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
  zstyle ':fzf-tab:*' popup-min-size 50 8
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
fi

# plugins 
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting


autoload -U compinit && compinit 


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no


# zsh-vi-mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# Keybindings
# History
HISTSIZE=10000
HISTFILE=~/.config/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# fzf setup
# ---------
if [[ ! "$PATH" == */home/nerdninja420/.config/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nerdninja420/.config/fzf/bin"
fi

source <(fzf --zsh)


# # nvm an nodejs setup export NVM_DIR="$HOME/.nvm"                            # You can change this if you want.
# export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
# [ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load N

# fnm
FNM_PATH="/home/nerd/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/nerd/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

if [ "$TTY" = "/dev/tty1" ]; then
  Hyprland
fi

# ohmyposh setup
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin.toml)"
