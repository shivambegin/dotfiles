export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_THEME="robbyrussell"

export EDITOR=nvim
export VISUAL=nvim
export MUSIC_APP="Spotify"


plugins=( git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting )

export PATH=$PATH:/home/shivam/.spicetify
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(oh-my-posh init zsh)"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(atuin init zsh)"

eval $(thefuck --alias)

setopt COMBINING_CHARS

export LANG=en_US.UTF-8
export LC_COLLATE=C
source_file() { [ -f "${1}" ] && . "${1}"; }

if [[ $TERM == "wezterm" ]]; then 
  TERM="xterm-256color" # <-- Specifically this is what did the trick
  source_file "$HOME/.config/wezterm/wezterm.sh"
fi 


alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=Nvchad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-test="NVIM_APPNAME=testing nvim"

function nvims() {
  items=("default" "kickstart" "LazyVim" "Nvchad" "AstroNvim" "testing")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^b "nvims\n"
alias todo="dooit"
alias art="cbonsai -l --seed=$(date +%s)"
alias timer="tomato"
alias ls='ls --color'
alias lines='tokei'
alias vi='nvim'
alias hx='helix'


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
export PATH=$HOME/.local/bin:$PATH
