# .ZSHRC
# ~~~~~~~
# vim: foldmethod=marker

# {{{1 ZSH Modules

autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup

# }}}

# {{{1 Custom functions
# Customize to your needs...
setenv() { export $1=$2 } # csh compatibility
buildvm() { ~/scripts/buildvm.sh $@ } # make etc
run() { ~/scripts/run.sh $@ } # tests etc
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}
build() { ~/scripts/build.sh $@ }
# }}}

# {{{1 Settings
setopt AUTO_CD
setopt MULTIOS
setopt CORRECT
setopt AUTO_PUSHD
setopt AUTO_NAME_DIRS
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
#setopt RM_STAR_WAIT
setopt ZLE
setopt NO_HUP
setopt VI
setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP
setopt NO_CLOBBER
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt RC_EXPAND_PARAM

# use vi mode
export EDITOR="vim"
bindkey -v
# 10ms for key sequences
KEYTIMEOUT=1

# paths
export PATH="~/scripts:~/.arcanist/arcanist/bin:/home/jharvey/bin/apache-maven-3.1.1/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:/usr/local/share/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH"
export JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk.x86_64"
#}}}

#{{{1 Aliases
alias grep='grep --color=auto'
alias ag='ag --color-line-number "1;35" --color-path "0;32" --color-match "30;47"'
alias h='history'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias eg='env | grep \!*'
alias psg='ps aux| grep \!*'
alias ls='ls --color=auto'
alias lf='ls -F'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls -ltr'

alias eclipse-cpp='~/scripts/run_eclipse-cpp.sh &'
alias eclipse-java='~/scripts/run_eclipse-java.sh &'
alias eclim='~/scripts/run_eclimd.sh &'
alias ssh='TERM=screen ssh -o ServerAliveInterval=300 -X'
alias vim='/usr/local/bin/vim --servername server'
alias ack='~/scripts/ack'
alias lua='~/bin/lua/lua-5.2.1/install/bin/lua'
alias clang++='~/bin/llvm/build/bin/clang++'
alias tig='/usr/local/bin/tig'
alias arc='~/.arcanist/arcanist/bin/arc'
# }}}

# {{{1 Locale
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export LC_COLLATE=en_GB.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_NUMERIC=en_GB.UTF-8
export LC_MONETARY=en_GB.UTF-8
export LC_MESSAGES=en_GB.UTF-8
export MM_CHARSET=en_GB.UTF-8
# }}}

#{{{1 Environment variables
export BUILD_VM="10.2.67.30"
export RUN_VM="10.2.67.113"
export CVSROOT=":pserver:jharvey@mack:/cvsroot/1.0"
export PROJECTS="/mnt/projects"
export BUILD_PREFIX="/home/jharvey/scripts/build.sh"
#}}}

#{{{1 Key bindings
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\eOB' down-line-or-history
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char
bindkey '\eOC' forward-char
bindkey '\eOD' backward-char
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char

#bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'u' undo
#}}}

#{{{ Completion Stuff
# Faster! (?)
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' menu 'select=0'
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-separator 'fREW'
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
zstyle ':completion::*:(rm|vi):*' ignore-line true
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed false
zstyle -e ':completion::*:hosts' hosts 'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g" /etc/ssh_known_hosts(N) ~/.ssh/known_hosts(N) 2>/dev/null | xargs) $(grep \^Host ~/.ssh/config(N) | cut -f2 -d\  2>/dev/null | xargs))'
#}}}

#{{{1 History Stuff
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
#}}}

# {{{1 Prompt
ZLE_RPROMPT_INDENT=0
# {{{ tmux titles
tmux_preexec() {
    if [ "$TMUX" != "" ]; then
        # set tmux-title to running program
        if [ "$TERM" = "screen-256color" ]; then
            printf "\033]2;$(echo "$1" | cut -d" " -f1)\033\\"
            printf "\033k$PWD\033\\"
        fi
        tmux setenv TMUXPWD_$(tmux display -p "#I") $PWD
    fi
}

tmux_precmd() {
    if [ "$TMUX" != "" ]; then
        if [ "$TERM" = "screen-256color" ]; then
            printf "\033]2;zsh\033\\"
            printf "\033k$PWD\033\\"
        fi
        tmux setenv TMUXPWD_$(tmux display -p "#I") $PWD
    fi
}
# }}}
# {{{ vi mode for prompt
setopt prompt_subst
CMD_MODE="NORMAL"
INS_MODE="INSERT"
VIMODE=$INS_MODE

zle-keymap-select () {
    VIMODE="${${KEYMAP/vicmd/${CMD_MODE}}/(main|viins)/${INS_MODE}}"
    __promptline
    zle reset-prompt
};
zle -N zle-keymap-select

zle-line-finish () {
    VIMODE=$INS_MODE
};
zle -N zle-line-finish
# }}}
# {{{ the prompt
precmd() {
    tmux_precmd
}

preexec() {
    tmux_preexec $1
}

source ~/.shell_prompt.sh

# }}}
# }}}


export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/jharvey/perl5";
export PERL_MB_OPT="--install_base /home/jharvey/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/jharvey/perl5";
export PERL5LIB="/home/jharvey/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/jharvey/perl5/bin:$PATH";
