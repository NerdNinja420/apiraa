# Alias for `git`
alias ga="git add"                 # git add <files>
alias gc="git commit -m"           # git commit <args>
alias gs="git status"              # git status
alias gps="git push"                # git push
alias gpl="git pull"               # git pull
alias gb="git branch -a"           # git branch -a
function gch(){
  local branch="$1"
  if [[ -z "$branch" ]]; then
    echo "Usage: gch(git chechout) 'branch-name'"
    return 1
  fi

  git checkout $branch
}

function gacp() {
  local files="$1"
  local message="$2"

  if [[ -z "$files" || -z "$message" ]]; then
    echo "Usage: gaddcommitpush 'filename(s)' 'commit message'"
    return 1
  fi

  git add $files && git commit -m "$message" && git push
}

# Alias for `tmux`
function tn { tmux new -s "${1:-}"; }              # tmux new-session <session-name>
function ta { tmux attach-session -t "${1:-}"; }   # tmux attach-session -t <session-name>
function tls { tmux list-session }                  # tmux kill-session -t <session_name>
function tk { tmux kill-session -t "${1:-}"; }     # tmux kill-session -t <session_name>
function tks { tmux kill-server }                  # tmux kill-server


# Alias for `ls`
alias ls='eza --long --header -a --icons --git --group-directories-first'
alias l='eza -a --icons --group-directories-first'
alias ll='eza --icons --git --group-directories-first'
alias lt='eza --long --header -a --icons --tree --git --group-directories-first'

# Alias for `cd`
alias ..='cd ..'
alias ...='cd ../../'

# Alias for `fzf`
alias f='fzf --preview="batcat --color=always {}" --height 40%'
alias fn='nvim $(fzf --preview="batcat --color=always {}" --height=40%)'

# Alias for `quick nevigation`
# alias conf='cd ~/.config/'
alias zrc='nvim ~/.zshrc'
alias note='cd ~/documents/note/'
alias notes='cd ~/documents/vaults/vg3_notes/'
alias doc='cd ~/documents/'
alias confn='cd ~/.config/nvim/'
alias confh='cd ~/.config/hypr'

function conf() {
  # if [[ -z $1 ]]; then
  #   echo "Usage: conf <first-letter>"
  #   return 1
  # fi

  case $1 in
    n) target_dir="$HOME/.config/nvim" ;;
    t) target_dir="$HOME/.config/tmux" ;;
    a) target_dir="$HOME/.config/alacritty" ;;
    k) target_dir="$HOME/.config/kitty" ;;
    h) target_dir="$HOME/.config/hypr" ;;
    w) target_dir="$HOME/.config/waybar" ;;
    z) target_dir="$HOME/.config/zshrc" ;;
    y) target_dir="$HOME/.config/yazi" ;;
    o) target_dir="$HOME/.config/ohmyposh" ;;
    *) target_dir="$HOME/.config/" ;;
      # echo "No matching directory for '$1' in ~/.config"
      # return 1
      # ;;
  esac

  if [[ -d "$target_dir" ]]; then
    cd "$target_dir" || { echo "Failed to navigate to $target_dir"; return 1; }
    echo "Now in $(pwd)"
  else
    echo "Directory $target_dir not found"
    return 1
  fi
}

# aliases
alias c='clear'
alias e='exit'
alias n='nvim'
alias lg='lazygit'
alias y='yazi'
alias astro='nvim'


# function conf() {
#   if [[ -z $1 ]]; then
#     echo "Usage: conf <first-letter>"
#     return 1
#   fi
#
#   local first_letter=$1
#
#   local target_dir
#   target_dir=$(find ~/.config -maxdepth 1 -type d -name "${first_letter}*" | head -n 1)
#
#   if [[ -n $target_dir ]]; then
#     cd "$target_dir" || echo "Failed to navigate to $target_dir"
#   else
#     echo "No directory found in ~/.config starting with '$first_letter'"
#   fi
# }







