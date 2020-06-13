source ~/.config/fish/alias.fish
source ~/.config/fish/path.fish

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