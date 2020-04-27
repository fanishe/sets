#!/bin/bash
# Creates ssh-connection for git
newdir=.ssh

if [ -d ~/$newdir ]; then
    echo "Directory $newdir exist"
else 
    echo "Create $newdir"
    mkdir ~/$newdir
    cd ~/$newdir
fi

echo "Make configs for git"
git config --global user.email fan.42@mail.ru
git config --global user.email fanishe

ssh-keygen -t rsa -b 4096 -C "fan.42@mail.ru" -f ~/$newdir/git_rsa
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/git_rsa

echo "<=== KEY FOR GitHub ===>"
cat ~/$newdir/git_rsa.pub

