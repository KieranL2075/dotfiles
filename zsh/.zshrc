

# Set the directory we want to store zinit and plugins
BASEDIR="${HOME}/Customizations/"

ZINIT_HOME="${BASEDIR}zinit/zinit.git"

# Create directory if doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

source /home/Kieran/Customizations/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/Kieran/Customizations/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /home/Kieran/Customizations/zsh-autosuggestions/zsh-autosuggestions.zsh

# The following lines were added by compinstall

zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/Kieran/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall
eval "$(starship init zsh)"

eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/home/Kieran/.ghcup/env" ] && source "/home/Kieran/.ghcup/env" # ghcup-env

bindkey '\ec' fzf-cd-widget

export LEAN_PATH="/home/Kieran/.elan/toolchains/leanprover--lean4---v4.17.0-rc1/lib/lean"
export PATH=$PATH:/home/Kieran/.spicetify

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/Kieran/.luarocks/share/lua/5.4/?.lua;/home/Kieran/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/Kieran/.luarocks/lib/lua/5.4/?.so'
export PATH='/home/Kieran/.luarocks/bin:/home/Kieran/.nvm/versions/node/v22.13.1/bin:/home/Kieran/.local/share/zinit/polaris/bin:/home/Kieran/.elan/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/Kieran/.local/share/JetBrains/Toolbox/scripts:/home/Kieran/.fzf/bin:/home/Kieran/.spicetify'
