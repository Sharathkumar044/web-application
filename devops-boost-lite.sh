#!/bin/bash

echo "🔧 Updating system..."
yum update -y

echo "📦 Installing CLI essentials..."
yum install -y git wget curl unzip vim tree htop net-tools jq tmux --allowerasing

# Check if git is installed before fzf setup
if ! command -v git &> /dev/null; then
  echo "❌ git is still missing. Please install it manually."
else
  echo "🔍 Installing fzf..."
  if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
  fi
fi

# Enhance .bashrc
echo "🛠️  Enhancing .bashrc with aliases and visuals..."
cat << 'EOF' >> ~/.bashrc

# 🌈 Fancy Prompt
export PS1="\[\e[1;36m\]\u@\h:\w\$ \[\e[0m\]"

# 🔁 Better History Timestamps
export HISTTIMEFORMAT="%F %T "

# 🧠 Useful Aliases
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias gc='git commit -m'
alias grep='grep --color=auto'

EOF

# Set timezone & hostname
echo "🌍 Setting timezone to Asia/Kolkata..."
timedatectl set-timezone Asia/Kolkata

echo "🧩 Setting hostname to devops-server..."
hostnamectl set-hostname devops-server

# Create personal cheatsheet
echo "📘 Creating ~/cheatsheet.txt..."
cat << 'EOC' > ~/cheatsheet.txt

# Git
git init
git add .
git commit -m "msg"
git push origin main

# System Monitoring
htop
tree -L 2

# Shortcuts
ll -> ls -alF

EOC

echo "✅ Setup complete! Now run: source ~/.bashrc"

