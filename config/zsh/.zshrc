# Enable colors and change prompt
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#PS1='%F{blue}%~ %(?.%F{green}.%F{red})$%f '
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
zle_highlight=('paste:none')   # Disable text highlight on paste

# History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

if [ ! -d $HOME/.cache/zsh ]; then
  mkdir -p $HOME/.cache/zsh
  echo "History file created."
fi

# Fish-like sudo function with alt key 
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line

# Defined shortcut keys
bindkey "^[s" sudo-command-line
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# bash-like behaviour for alt key
autoload -U select-word-style
select-word-style bash

# Load aliases and add PATH
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias"
export PATH=$HOME/.cargo/bin/:$HOME/.local/bin/:$PATH

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Fetching required plugins 
function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ ! -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    printf "Fetching plugins: \033[32m$PLUGIN_NAME\033[0m..."
    git clone --depth=1 "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME" 2>/dev/null
    echo "\033[34mDone\033[0m!"
  fi
}

zsh_add_plugin "agkozak/zsh-z"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

source "$ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
source "$ZDOTDIR/zmachine.zsh-theme"