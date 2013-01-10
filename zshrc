# {{{1 ZSH Modules

autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup

# }}}

# {{{1 Custom functions
# Customize to your needs...
setenv() { export $1=$2 } # csh compatibility
build() { ~/scripts/build.sh $@ } # make etc
run() { ~/scripts/run.sh $@ } # tests etc
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}
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
setopt RM_STAR_WAIT
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

# paths
export PATH="~/scripts:~/.arcanist/arcanist/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
#}}}

#{{{1 Aliases
alias grep='grep --color=auto'
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
alias ssh='ssh -o ServerAliveInterval=300'
alias vim='/usr/local/bin/vim --servername server'
alias ack='~/scripts/ack'
alias lua='~/bin/lua/lua-5.2.1/install/bin/lua'
alias clang++='~/bin/llvm/build/bin/clang++'
alias tig='/usr/local/bin/tig'
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
export RUN_VM="10.2.67.27"
export CVSROOT=":pserver:jharvey@mack:/cvsroot/1.0"
export PROJECTS="/mnt/projects"
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
# {{{ vi mode for prompt and cursor
setopt prompt_subst
CMD_MODE=$'%{\e[01;38;05;22m%}%{\e[01;48;05;148m%} CMD %{\e[0m%}'
INS_MODE=$'%{\e[01;38;05;24m%}%{\e[01;48;05;253m%} INS %{\e[0m%}'

zle-keymap-select () {
  if [ "$TERM" = "screen-256color" ]; then
    if [ "$KEYMAP" = vicmd ]; then
      printf '\033Ptmux;\033\033]12;red\007\033\\'
      VIMODE=$CMD_MODE
    else
      printf '\033Ptmux;\033\033]12;orange\007\033\\'
      VIMODE=$INS_MODE
    fi
  elif [ "$TERM" != "linux" ]; then
    if [ "$KEYMAP" = vicmd ]; then
      echo -ne "\033]12;red\007"
      VIMODE=$CMD_MODE
    else
      echo -ne "\033]12;orange\007"
      VIMODE=$INS_MODE
    fi
  fi

  zle reset-prompt
};

zle-line-init () {
  zle -K vicmd
  zle reset-prompt

  if [ "$TERM" = "screen" ]; then
    printf '\033Ptmux;\033]12;red\007\033\\'
  elif [ "$TERM" != "linux" ]; then
    echo -ne "\033]12;red\007"
  fi
};

zle -N zle-line-init
zle -N zle-keymap-select

vi_prompt_precmd() {
    VIMODE=$CMD_MODE
}
# }}}

# {{{ vcs_info for prompt
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr $'%{\e[01;38;05;240m%}%{\e[01;48;05;250m%} STAGED %{\e[0m%}'
zstyle ':vcs_info:*' unstagedstr $'%{\e[01;38;05;24m%}%{\e[01;48;05;253m%} UNSTAGED %{\e[0m%}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn cvs
vcs_prompt_precmd() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats $'%u%c%{\e[01;38;05;88m%}%{\e[01;48;05;208m%} %b %{\e[0m%}'
    } else {
        zstyle ':vcs_info:*' formats $' %{\e[01;38;05;196m%}%{\e[01;48;05;255m%} UNTRACKED %u%c%{\e[01;38;05;88m%}%{\e[01;48;05;208m%} %b %{\e[0m%}'
    }

    vcs_info
}
# }}}

# {{{ other variables for prompt
ROOT=$'%{\e[01;38;05;255m%}%{\e[01;48;05;196m%} ROOT %{\e[0m%}'
FAILED=$'%{\e[01;38;05;196m%}%{\e[01;48;05;255m%} FAILED %{\e[0m%}'
MACHINE=$'%{\e[01;38;05;246m%}%{\e[01;48;05;252m%} %m %{\e[0m%}'
USER=$'%{\e[01;38;05;240m%}%{\e[01;48;05;246m%} %n %{\e[0m%}'
LOCATION=$'%{\e[01;38;05;255m%}%{\e[01;48;05;240m%} %~ %{\e[0m%}'
#PATH=$'%{\e[01;48;05;240m%}%B%F{white} ${${(%):-%~}//\//%B%F{red}/%B%F{white}} %{\e[0m%}'
# }}}

# {{{ the prompt
precmd() {
    tmux_precmd
    vcs_prompt_precmd
    vi_prompt_precmd
}

preexec() {
    tmux_preexec $1
    echo -ne "\e[0m"
}

PROMPT='%(!/${ROOT}/)%(?//${FAILED})${VIMODE} %B'

RPROMPT='%
${vcs_info_msg_0_}%
${LOCATION}%
%(!/${ROOT}/${USER})%
${MACHINE}'

#%{%B%F{red}%K{blue}%} ${${(%):-%~}//\//%B%F{red\}/%B%F{white\}} %
# }}}
# }}}

