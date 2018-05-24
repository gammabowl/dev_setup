## system alias ##
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias path='echo -e ${PATH//:/\\n}' # path: Echo all executables in PATH
alias s='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl' # s: opens sublime to edit file
alias flushDNS="dscacheutil -flushcache" # flushDNS: flushes DNS cache
alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'" # localip: local IP address

## docker ##
alias unset="unset ${!DOCKER_*}" # Unset old docker environment variables

# docker alias
alias dclean="docker ps -aq | xargs docker rm -f"
alias dcleani="docker images -q | xargs docker rmi -f"

## GIT alias ##
alias gb="git branch"
alias gst="git status -uno"
alias gco="git checkout"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gcmsg="git commit -m"
alias gcamend="git commit --amend"

## terminal history limits
HISTFILESIZE=500000000
HISTSIZE=500000000

## adfs login ##
alias adfs="aws-adfs login --adfs-host=<sso.hostname> --session-duration 30000"


## ssh functions - thanks to https://github.com/suanmeiguo ##
# multilogin
# "ssh_appname stage"
ssh_appname () {
    echo "csshx-ing into all <app.name> on $1"
    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:App,Values=<app.name>" "Name=tag:Env,Values=$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} PrivateIpAddress\" | cut -f2 -d":" | sed 's/[\",]//g' | uniq -u | xargs csshx --login <aws.username>
}

# login to ec2 instances using public ip via name
# "ssh_login example-stage-ecs-asg"
ssh_login () {
    echo "csshx-ing into all instances: $1"
    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} PublicIpAddress | cut -f2 -d":" | sed 's/[\",]//g' | xargs csshx --login <aws.username>
}

# login to ec2 instances using private ip via name
# "ssh_vpc example-stage-ecs-asg"
ssh_vpc () {
    echo "csshx-ing into all instances: $1"
    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} PrivateIpAddress\" | cut -f2 -d":" | sed 's/[\",]//g' | uniq -u | xargs csshx --login <aws.username>
}

# login to ec2 instances via instance id
# "ssh_i i-0a423452345e3d72"
ssh_i () {
    ip=$(aws ec2 describe-instances --region us-east-1 --filters "Name=instance-id,Values=$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} PrivateIpAddress\" | cut -f2 -d":" | sed "s/[\",]//g" | uniq -u)
    ssh $ip
}

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   https://gist.github.com/natelandau/10654137
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

## Languages & Build tools ##
export SCALA_HOME=/usr/local/bin/scala  
export PATH=$PATH:$SCALA_HOME/bin

export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PATH=$PATH:$GROOVY_HOME/bin

export GRADLE_HOME=/usr/local/opt/gradle/libexec
export PATH=$GRADLE_HOME/bin:$PATH


## pyenv ##
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

