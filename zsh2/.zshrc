
export XDG_CONFIG_HOME="$HOME/.config"
PATH=$HOME/.composer/vendor/bin:$PATH:
PATH=$HOME/.local/bin:$PATH:
PATH=$HOME/.local/bin/collection:$PATH:
PATH=$HOME/go/bin:$PATH:
PATH=$HOME/.local/locations:$PATH:
PATH=$HOME/node_modules/.bin:$PATH:
PATH=$HOME/.cargo/bin:$PATH:
PATH=$HOME/development/esp-idf/tools:$PATH:
PATH=$HOME/Downloads/gcc-arm-9.2-2019.12-aarch64-arm-none-linux-gnueabihf/bin:$PATH:

PATH="/home/maren/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/maren/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/maren/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/maren/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/maren/perl5"; export PERL_MM_OPT;

export EDITOR=/usr/sbin/nvim
export VISUAL=/usr/sbin/nvim

export LANG=en_US.UTF-9
export LC_ALL=en_US.UTF-8
export JAVA_HOME=/usr/lib/jvm/default

export COREMAN_HOME="/srv/integration/utils/coreman"
export PATH="${PATH}:${COREMAN_HOME}/bin"

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git '
export FZF_DEFAULT_OPTS="--ansi"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
(cat ~/.cache/wal/sequences &)

export BROWSER=/usr/bin/qutebrowser

alias unrar='unrar x'
alias dev='cd ~/development'
alias untar='tar xzvf'
alias c='clipcopy'
alias v='clippaste'

alias fqsn="zsh ~/.local/bin/fqsnExporter.sh"
alias pro="zsh ~/.local/bin/openProject.sh"

alias vpnaddress="hostname -i | cut -f5 -d' ' | c"
alias tag="git branch | grep \* | cut -d ' ' -f2"
alias gitremote="git remote -v | head -n1 | cut -f2 | sed s/\(fetch\)//g | c"
ipaddrtemp=$(ip -j addr | jq '.[]  | select (.ifname == "ppp0").addr_info[].local')

alias ipaddr="echo $(echo "maren@$ipaddrtemp\:support")"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias comment='f() { jira comment $1 };f' 
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

alias mpv="devour mpv --input-ipc-server=/tmp/mpvsocket "
alias qutebrowser="devour qutebrowser"
alias zathura="devour zathura"
alias sabnzbd="devour /usr/lib/sabnzbd/SABnzbd.py"
alias get_idf='. $HOME/development/esp-idf/export.sh'
alias vim='/usr/sbin/nvim'

alias listPods='kubectl -n it-integration get pods' 

function restartPod {
    pod=$(kubectl get pods | fzf); kubectl delete pod $(echo $pod | cut -f1 -d' ')
}

function podLogs {
    pod=$(kubectl get pods | fzf); kubectl logs $(echo $pod | cut -f1 -d' ') -f
}


function podLog {
    pod=$(kubectl get pods | fzf); kubectl logs $(echo $pod | cut -f1 -d' ') > output.logs
}

function lastCommit {
    repoUrl=$(git config --get remote.origin.url |sed -e 's/:/\//' -e 's/git@/https:\/\//' -e 's/\.git//'); commit=$(git log | head -n1 | sed -e 's/commit //') ; echo $repoUrl/commit/#$commit

}
eval "$(jira --completion-script-zsh)"


autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
autoload -U promptinit; promptinit                                                                                                                                                                               
prompt spaceship  

source "$HOME/.fzf/shell/key-bindings.zsh"
source ~/dotfiles/.credencials
source ~/dotfiles/zsh/ghCompletion.zsh
source ~/.cache/wal/colors-tty.sh
source /home/maren/.config/broot/launcher/bash/br
source ~/exportedVars
