#!/bin/bash

echo "🔧 Updating system..."
yum update -y

echo "🛠️ Installing essential tools..."
yum install -y git curl vim tree htop tmux net-tools wget unzip

echo "📜 Setting up persistent bash history..."
echo 'HISTSIZE=5000' >> ~/.bashrc
echo 'HISTFILESIZE=10000' >> ~/.bashrc
echo 'PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> ~/.bashrc

echo "🎨 Enabling colorful and informative prompt..."
echo 'alias ls="ls --color=auto -lah"' >> ~/.bashrc
echo 'PS1="\[\e[32m\]\u@\h \[\e[33;1m\]\w \[\e[36m\]\$(git branch 2>/dev/null | grep \"*\" | sed \"s/* //\")\[\e[0m\]$ "' >> ~/.bashrc

echo "⚡ Adding handy aliases..."
cat <<EOF >> ~/.bashrc

# ===== DevOps Quick Aliases =====
alias gs='git status'
alias gc='git commit -m'
alias ga='git add .'
alias k='kubectl'
alias d='docker'
alias dc='docker-compose'
EOF

echo "📘 Creating your DevOps cheatsheet..."
cat <<'EOC' > ~/cheatsheet.txt
# DevOps Cheatsheet

## Git
gs       = git status
ga       = git add .
gc "msg" = git commit -m "msg"

## Docker
d ps     = docker ps
d rmi    = docker rmi
dc up    = docker-compose up -d

## Kubernetes
k get pods
k apply -f file.yaml

## System
htop     = interactive process viewer
tree     = directory tree view

## Others
ls       = ls -lah (color view)
EOC

echo "🌍 Setting timezone to Asia/Kolkata..."
timedatectl set-timezone Asia/Kolkata

echo "🧩 Setting hostname to devops-server..."
hostnamectl set-hostname devops-server

echo "✅ All set! Run this to apply changes now:"
echo "   👉 source ~/.bashrc"

