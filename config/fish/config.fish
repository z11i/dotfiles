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

# set colors if colors.fish exists
sourceadd ~/.config/fish/colors.fish

# set editor
if type -q nvim
    set -Ux EDITOR nvim
else if type -q vim
    set -Ux EDITOR vim
else if type -q vi
    set -Ux EDITOR vi
end
set -Ux VISUAL "$EDITOR"

# disable fish welcome message
set fish_greeting 

# jenv
if type -q jenv
    status --is-interactive; and source (jenv init -|psub)
end

# thefuck
if type -q thefuck
    thefuck --alias | source
end

# starship prompt
if type -q starship
    starship init fish | source
end

# less with color
if set -u lesspipe (type -p src-hilite-lesspipe.sh)
    set -Ux LESSOPEN "| $lesspipe %s"
    set -Ux LESS ' -R'
end