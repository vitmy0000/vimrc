##-- zplug {{{--
# git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "hlissner/zsh-autopair", defer:2
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "vifon/deer", use:deer

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load #--verbose
##}}}

##-- setup {{{--
# append the follow lines to .bashrc
# to set default shell to zsh without root permission
: <<'END'
export SHELL=$(which zsh)
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
END
# export this variable so to enable bash sub-shell
export ZSH_VERSION=$ZSH_VERSION
##}}}

##-- history {{{--

##-- cmd history {{{--
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
# append history without waiting until the shell exits
setopt INC_APPEND_HISTORY
# do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
##}}}

##-- dir history {{{--
setopt AUTO_CD
# dir history stack
setopt AUTO_PUSHD PUSHD_MINUS PUSHD_SILENT PUSHD_TO_HOME
export DIRSTACKSIZE=10
##}}}

##}}}

##-- completion {{{--
autoload -U compinit
compinit
# allow completion from within a word/phrase
setopt complete_in_word
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
##}}}

##-- alias {{{--
alias vi='vim'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -la'
# dir history
alias dh='dirs -v'
# history sync
alias hs='fc -R'
# shell level
alias sl='echo $SHLVL'
# icheat for history
alias hh='python ~/iCheat/icheat.py -s ~/.zsh_history'
##}}}

##-- plugins {{{--

##-- bhilburn/powerlevel9k {{{--
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('status' 'time' 'dir' 'vcs' 'background_jobs')
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_STATUS_OK_BACKGROUND='237'
# show color
: <<'END'
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
END
##}}}

##-- vifon/deer {{{--
zle -N deer-launch
bindkey '\ef' deer-launch
##}}}

##-- fzf(installed as vim plugin) {{{--
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
##}}}

##}}}

##-- keybindings {{{--
# consistent ctrl-u behaviour
bindkey '^u' backward-kill-line
##}}}


