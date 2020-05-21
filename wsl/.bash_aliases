#=== My Aliases ===
alias c='clear'
alias q='exit'
alias ls='ls -a --color=auto'
alias upd='sudo apt-get update'
alias upg='sudo apt-get upgrade'
alias updg='sudo apt-get update && sudo apt-get upgrade -y'
alias adal='sudo vim ~/.bash_aliases'
alias refal='source ~/.zshrc'
alias venv='source venv/bin/activate'
alias out='deactivate'
#=== Server ===
alias fddns='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/server_rsa && ssh -p 40408 fantomas@fantomas.ddns.net'
alias dev='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/dev_rsa && ssh developer@192.168.11.132 -p 22'
alias aws='ssh -i ~/.ssh/"aws_webserver_frankfurt.pem" ubuntu@ec2-3-120-204-255.eu-central-1.compute.amazonaws.com'

#=== Develop ===
alias bot='cd /mnt/c/Users/PC/Documents/GitHub/bot'
alias desctop='cd /mnt/c/Users/PC/Desktop'
alias doc='cd /mnt/c/Users/PC/Documents'
alias gh='cd /mnt/c/Users/PC/Documents/GitHub/'
alias evalgit='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/git_rsa'
#alias evaldev='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/dev_rsa'
alias myflask='cd /mnt/c/Users/PC/Documents/GitHub/flask/microblog/'
alias pip='pip3'
alias py='python3'

#=== docker ===
alias drmi='docker rmi $(docker images -q)'
alias drm='docker rm $(docker ps -a -q)'
alias drmall='docker rm $(docker ps -a -q) && docker rmi $(docker images -q) --force'
