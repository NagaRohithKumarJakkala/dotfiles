
export ZSH="$HOME/.oh-my-zsh"

eval "$(/home/rohith/.local/bin/oh-my-posh init zsh --config /home/rohith/.config/ohmyposh/amro.omp.json)"



# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"



DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8


alias c="clear"
source <(fzf --zsh)
alias keybind="nvim ~/.config/hypr/conf/keybindings/custom.conf"
alias zrc="nvim .zshrc"
alias y="yazi"
alias vim="nvim"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'
export VISUAL='nvim'
alias nv="nvim"
alias nn="NVIM_APPNAME=nvim-next nvim"

alias -s md='bat'
alias -s png='eog'
alias -s go='$EDITOR' 
alias -s cpp='$EDITOR' 
alias -s js='$EDITOR' 
alias -s jsx='$EDITOR' 
alias -s tsx='$EDITOR' 
alias -s ts='$EDITOR' 
alias -s java='$EDITOR' 
alias -s c='$EDITOR' 
alias -s h='$EDITOR' 
alias -s py='$EDITOR' 

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

z() {
    if [[ ! -f "$1" ]]; then
        echo "File not found: $1"
        return 1
    fi

    wl-copy < "$1"
    echo "Copied '$1' to clipboard."
}

ch() {
    curl -s http://localhost:11434/api/generate \
        -d "$(jq -n \
            --arg prompt "$*" \
            '{
                model: "qwen2.5-coder",
                prompt: $prompt,
                stream: false
            }')" |
        jq -r '.response' |
        xargs -0 notify-send
}
