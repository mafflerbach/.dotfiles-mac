# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export XDG_CONFIG_HOME="$HOME/.config"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$HOME/.composer/vendor/bin:$PATH:
PATH=$HOME/.local/bin:$PATH:
PATH=$HOME/.local/bin/collection:$PATH:
PATH=$HOME/go/bin:$PATH:
PATH=$HOME/.local/locations:$PATH:
PATH=$HOME/node_modules/.bin:$PATH:
PATH=$HOME/.cargo/bin:$PATH:
PATH=$HOME/development/esp-idf/tools:$PATH:
PATH=$HOME/Downloads/gcc-arm-9.2-2019.12-aarch64-arm-none-linux-gnueabihf/bin:$PATH:


export EDITOR=/usr/sbin/nvim
export VISUAL=/usr/sbin/nvim
# Path to your oh-my-zsh installation.
# stty -ixon
  export ZSH="/home/maren/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
  ZSH_TMUX_AUTOSTART=true
  ZSH_TMUX_FIXTERM=true







# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 # ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  tmux
  kubectl
  )

source $ZSH/oh-my-zsh.sh
source ~/.dotfiles/misc/zsh/ghCompletion.sh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# cd()
# {
#     builtin cd $@
#     ls -l 
# }


alias unrar='unrar x'
alias dev='cd ~/development'
alias untar='tar xzvf'
alias c='clipcopy'
alias v='clippaste'

alias fqsn="zsh ~/.local/bin/fqsnExporter.sh"
alias pro="zsh  ~/.local/bin/collection/selectproject.sh"


alias vpnaddress="hostname -i | cut -f5 -d' ' | c"
alias branches="git branch | grep \* | cut -d ' ' -f2"
alias gitremote="git remote -v | head -n1 | cut -f2 | sed s/\(fetch\)//g | c"
ipaddrtemp=$(ip -j addr | jq '.[]  | select (.ifname == "ppp0").addr_info[].local')
alias ipaddr="echo $(echo "maren@$ipaddrtemp\:support")"
source ~/exportedVars
export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source "$HOME/.fzf/shell/key-bindings.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

ZSH_TMUX_AUTOSTART=true

(cat ~/.cache/wal/sequences &)


# async apply to terminal emulator
 (cat ~/.cache/wal/sequences &)
# # synchronous alternative 
 cat ~/.cache/wal/sequences
#
# # apply color scheme to TTY
 source ~/.cache/wal/colors-tty.sh


autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

eval "$(jira --completion-script-zsh)"

export LANG=en_US.UTF-9
export LC_ALL=en_US.UTF-8
export JAVA_HOME=/usr/lib/jvm/default

export COREMAN_HOME="/srv/integration/utils/coreman"
export PATH="${PATH}:${COREMAN_HOME}/bin"



alias comment='f() { jira comment $1 };f' 
alias subtaskUnassign='f() { jira unassign $1 };f' 
alias subtaskAssign='f() { jira assign $1 m9338  };f' 
alias subtaskReview='f() { jira transition "In Review" $1 };f' 
alias subtaskProgress='f() { jira transition "In Progress" $1 };f' 
alias subtaskDone='f() { jira transition "Done" $1 };f' 
alias sprint='jira listStories' 
alias subtask='f() { jira listSubtasks $1};f' 
alias subtaskView='f() { jira view $1};f' 
alias tree=br
alias gent="mkdir tags; ctags --tag-relative=yes -R -f tags/tags  --fields=+aimlS"
alias bigFiles="du -a . | sort -n -r | head -n 20"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BROWSER=/usr/bin/qutebrowser
export DISPLAY=:0.0

alias mpv="devour mpv --input-ipc-server=/tmp/mpvsocket "
alias qutebrowser="devour qutebrowser"
alias zathura="devour zathura"
alias sabnzbd="devour /usr/lib/sabnzbd/SABnzbd.py"
alias get_idf='. $HOME/development/esp-idf/export.sh'
alias vim='/usr/sbin/nvim'
alias ls='exa --icons --git -a'

function restartPod {
    pod=$(kubectl get pods | fzf); kubectl delete pod $(echo $pod | cut -f1 -d' ')
}

function podLogs {
    pod=$(kubectl get pods | fzf); kubectl logs $(echo $pod | cut -f1 -d' ') -f
}

function context {
    context="dev-it-integration\nstage-it-integration\nprod-it-integration"
    context=$(echo $context | fzf); 
    kubectl config use-context $context
}

function podLog {
pod=$(kubectl get pods | fzf); kubectl logs $(echo $pod | cut -f1 -d' ') > output.logs
}

alias listPods='kubectl -n it-integration get pods' 

function lastCommit {
repoUrl=$(git config --get remote.origin.url |sed -e 's/:/\//' -e 's/git@/https:\/\//' -e 's/\.git//'); commit=$(git log | head -n1 | sed -e 's/commit //') ; echo $repoUrl/commit/#$commit

}


PATH="/home/maren/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/maren/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/maren/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/maren/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/maren/perl5"; export PERL_MM_OPT;


#source ~/dotfiles/.credencials

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

source /home/maren/.config/broot/launcher/bash/br
