source ~/.config/fish/alias.fish
source ~/.config/fish/keybindings.fish
source ~/.config/fish/path.fish

# bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
    fisher install <$__fish_config_dir/fish_plugins
end

# Source secret if it exists
sourceadd ~/.config/fish/secret.fish

# set colors if colors.fish exists
sourceadd ~/.config/fish/colors.fish

# set editor
if type -q hx
    set -gx EDITOR hx
else if type -q nvim
    set -gx EDITOR "nvim --clean"
else if type -q vim
    set -gx EDITOR vim
else if type -q vi
    set -gx EDITOR vi
end
set -gx VISUAL "$EDITOR"

# disable fish welcome message
set fish_greeting

# thefuck
if type -q thefuck
    thefuck --alias | source
end

# starship prompt
if type -q starship
    starship init fish | source
end

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# ripgrep
if type -q rg
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
end

if type -q fzf
    set -U FZF_LEGACY_KEYBINDINGS 0
end

# brew completion
if type -q brew
    if test -d (brew --prefix)"/share/fish/completions"
        path_append (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        path_append (brew --prefix)/share/fish/vendor_completions.d
    end
end

# gcloud
if test -e '~/google-cloud-sdk/path.bash.inc'
    bass source '~/google-cloud-sdk/path.bash.inc'
end

# optionally source asdf because it does not check whether it has already been sourced
if not contains ~/.asdf/shims $PATH
    sourceadd ~/.asdf/asdf.fish
end

if type -q direnv
    direnv hook fish | source
end

# Source completions. Somehow when re-entering fish, such as in tmux, or just do `fish` again,
# the completions under ~/.config/fish/completions are not used. Only directory completions become available.
### for f in ~/.config/fish/completions/*.fish
###     source $f
### end

sourceadd ~/.config.fish

## Cursor integration
if type -q cursor
    string match -q "$TERM_PROGRAM" vscode
    and . (cursor --locate-shell-integration-path fish)
    and echo "Cursor integration loaded"
end
