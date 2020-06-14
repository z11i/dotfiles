source ~/.config/fish/alias.fish
source ~/.config/fish/path.fish

# bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Source secret if it exists
sourceadd ~/.config/fish/secret.fish

# set editor
set -Ux EDITOR nvim

# disable fish welcome message
set fish_greeting 

# jenv
status --is-interactive; and source (jenv init -|psub)

# thefuck
thefuck --alias | source

# starship prompt
starship init fish | source