#!/bin/bash

# 1. Establish path to Oh My Zsh custom plugins folder
ZSH_CUSTOM_PLUGINS="/root/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_CUSTOM_PLUGINS"

# 2. Clone the goodies if they aren't already present
if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"
fi

# 3. Activate the plugins inside the newly generated .zshrc
# This transforms plugins=(git) into plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /root/.zshrc

# 4. Append your custom multi-line prompt safely to the end of the file
# Using a literal multi-line string here ensures it skips shell parsing errors
cat << 'EOF' >> /root/.zshrc

# Custom Multi-line Prompt Configuration
PROMPT="%F{cyan}%~%f %(?.%F{green}✓%f.%F{red}✗%f)
$ "
EOF