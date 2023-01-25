# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
export XDG_CONFIG_HOME="$HOME/.config"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$HOME/.composer/vendor/bin:$PATH:
PATH=$HOME/.local/bin:$PATH:
PATH=$HOME/.local/bin/collection:$PATH:
PATH=$HOME/go/bin:$PATH:
PATH=/opt/homebrew/bin:$PATH:
PATH=$HOME/.local/locations:$PATH:
PATH=$HOME/node_modules/.bin:$PATH:
PATH=$HOME/.cargo/bin:$PATH:
PATH=$HOME/development/esp-idf/tools:$PATH:
PATH=$HOME/Downloads/gcc-arm-9.2-2019.12-aarch64-arm-none-linux-gnueabihf/bin:$PATH:
PATH=/bin/:$PATH:

export EDITOR=/opt/homebrew/bin/nvim
export VISUAL=/opt/homebrew/bin/nvim
# Path to your oh-my-zsh installation.
# stty -ixon
export ZSH="/Users/maren/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"
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
# source ~/.oh-my-zsh/plugins/arduino-cli.zsh
source ~/.dotfiles/misc/zsh/ghCompletion.sh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
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


alias branches="git branch | grep \* | cut -d ' ' -f2"
alias gitremote="git remote -v | head -n1 | cut -f2 | sed s/\(fetch\)//g | c"
# ipaddrtemp=$(ip -j addr | jq '.[]  | select (.ifname == "tun0").addr_info[0].local')
alias vpnaddress="echo $(echo "maren@$ipaddrtemp\:support")"


alias ipaddr="ip -j addr | jq '.[].addr_info[0] | select(.label==\"enp0s13f0u1u1i5\" or .label==\"enp0s31f6\" or .label==\"enp6s0u1\" or .label==\"wlp0s20f3\") | [.label,.local ]  | @sh' | sed -e \"s/'//g\" -e 's/\"//g'"

alias urldecode='sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b"'


alias b64decode="echo -n '$1' | base64 --decode"

alias b64encode="echo -n '$1' | base64"








# source ~/exportedVars
export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# source "$HOME/.fzf/shell/key-bindings.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


ZSH_TMUX_AUTOSTART=true

# # synchronous alternative 
# cat ~/.cache/wal/sequences
#
# # apply color scheme to TTY
# source ~/.cache/wal/colors-tty.sh


autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


export LC_ALL=en_US.UTF-8
export JAVA_HOME=/usr/lib/jvm/default

export COREMAN_HOME="/srv/integration/utils/coreman"
export PATH="${PATH}:${COREMAN_HOME}/bin"



alias tree=br
alias bigFiles="du -a . | sort -n -r | head -n 20"


alias deplDev="paws oneinf-integration-dev; sops -d values/dev/secrets.enc.yaml > values/dev/secrets.yaml; ansible-playbook playbooks/solution.yml -t setup,confi,deploy -i inventories/dev"
alias deplStage="paws oneinf-integration-stage; sops -d values/stage/secrets.enc.yaml > values/stage/secrets.yaml; ansible-playbook playbooks/solution.yml -t setup,confi,deploy -i inventories/stage"
alias deplProd="paws oneinf-integration-prod; sops -d values/prod/secrets.enc.yaml > values/prod/secrets.yaml; ansible-playbook playbooks/solution.yml -t setup,confi,deploy -i inventories/prod"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BROWSER=/opt/homebrew/bin/qutebrowser
export DISPLAY=:0

alias mpv="devour mpv --input-ipc-server=/tmp/mpvsocket "
alias zathura="devour zathura"
alias sabnzbd="devour /usr/lib/sabnzbd/SABnzbd.py"
alias get_idf='. $HOME/development/esp-idf/export.sh'
alias vim='/opt/homebrew/bin/nvim'
alias ls='exa --icons --git -a'

function config {
    cd ~/.dotfiles; vim
}

function fkill {
    kill $(ps aux | fzf | cut -f5 -d' ')
}

function restartPod {
    pod=$(kubectl get pods -n it-integration | fzf); kubectl delete pod $(echo $pod | cut -f1 -d' ') -n it-integration
}


function podLogs {
    pod=$(kubectl get pods -n it-integration | fzf); kubectl logs $(echo $pod | cut -f1 -d' ') -f -n it-integration
}

function podFor {
    pod=$(kubectl get pods -n it-integration | fzf); kubectl port-forward $(echo $pod | cut -f1 -d' ') 5005:5005 -n it-integration
}

function podLogin {
    pod=$(kubectl get pods  -n it-integration| fzf); kubectl exec -it $(echo $pod | cut -f1 -d' ')  -n it-integration -- sh
}
function descpod {
    pod=$(kubectl get pods  -n it-integration | fzf); kubectl describe pod $(echo $pod | cut -f1 -d' ') -n it-integration
}

function podconf {
    pod=$(kubectl get configmaps -n it-integration -o name | sed "s/configmap\///g" | fzf); kubectl get configmaps -n it-integration $(echo $pod )  -o yaml

}




function undeploy {


    if [ "$1" != "" ]; then 
        service="$1"
    else 
        pod=$(kubectl get pods   -n it-integration| fzf);
        IN=$(echo $pod | cut -f1 -d' ' | rev)     
        foo=${IN//\-/ }
        parts=(${(@s: :)foo})
        parts=(${parts:2})
        service=$(echo ${(j:-:)parts} | rev)
    fi

    kubectl delete deployment $service  -n it-integration
}

function ehs {

    file=$(fzf -q "charts secret ")
helm secrets enc $file

}
function dhs {

    file=$(fzf -q "secret yaml")
helm secrets edit $file

}


function paws {

    if [ "$1" != "" ]; then 
        aws_profile="$1"
    else 
        aws_profile=$(aws configure list-profiles | fzf )
    fi

    if [ "$aws_profile" = "oneinf-integration-dev" ]; then 
        export SOPS_KMS_ARN="arn:aws:kms:eu-west-1:787242137700:key/5b38d0d1-cd74-44b2-86ec-ec1dc621f0ee"
        export AWS_PROFILE=oneinf-integration-dev

        context="oneinf-integration-dev"
    fi

    if [ "$aws_profile" = "oneinf-integration-stage" ]; then 
        export SOPS_KMS_ARN="arn:aws:kms:eu-west-1:345305210404:key/3dab200e-7d61-4a8f-bc05-acefbabe1269"
        export AWS_PROFILE=oneinf-integration-stage

        context="oneinf-integration-stage"
    fi

    if [ "$aws_profile" = "oneinf-integration-prod" ]; then 
        export SOPS_KMS_ARN="arn:aws:kms:eu-west-1:970612681725:key/81ec6758-0acd-468b-af08-9ca963bdaacc"
        export AWS_PROFILE=oneinf-integration-prod

        context="oneinf-integration-prod"
    fi

    if [ "$aws_profile" = "dev-it-integration" ]; then 
        export SOPS_KMS_ARN="arn:aws:iam::227837763243:role/dev-k8s-main-it-integration-Developers"
        export AWS_PROFILE=int_dev

        context="dev-it-integration"
    fi

    if [ "$aws_profile" = "stage-it-integration" ]; then 
        export SOPS_KMS_ARN="arn:aws:iam::227837763243:role/stage-k8s-main-it-integration-Developers"
        export AWS_PROFILE=int_stage

        context="stage-it-integration"
    fi

    if [ "$aws_profile" = "prod-it-integration" ]; then 
        export SOPS_KMS_ARN="arn:aws:iam::066028779825:role/prod-k8s-main-it-integration-Developers"
        export AWS_PROFILE=int_prod
        context="prod-it-integration"
    fi

    kubectl config use-context $context
}

# kubectl exec -it <pod name> -c logging -- sh

function context {


    context="oneinf-integration-dev\noneinf-integration-prod\noneinf-integration-stage\stage-it-integration\ndev-it-integration\nprod-it-integration\nrancher-desktop\nstage-it-integration"
    context=$(echo $context | fzf); 
    kubectl config use-context $context


}


alias listPods='kubectl  get pods -n it-integration' 
function wae {
    watson edit $(watson log -s | fzf | cut -d',' -f1)
}



function lastCommit {
    repoUrl=$(git config --get remote.origin.url |sed -e 's/:/\//' -e 's/git@/https:\/\//' -e 's/\.git//'); commit=$(git log | head -n1 | sed -e 's/commit //') ; echo $repoUrl/commit/#$commit

}


PATH="/Users/maren/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/maren/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/maren/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/maren/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/maren/perl5"; export PERL_MM_OPT;


#source ~/dotfiles/.credencials

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
# [[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

# source /home/maren/.config/broot/launcher/bash/br

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


eval "$(starship init zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/maren/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
