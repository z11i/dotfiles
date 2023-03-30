source ~/.config/fish/alias.fish
source ~/.config/fish/path.fish
sourceadd ~/.config.fish

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
if type -q nvim
    set -gx EDITOR nvim
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

# brew completion
if type -q brew
    if test -d (brew --prefix)"/share/fish/completions"
        fish_add_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        fish_add_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

# gcloud
if test -e '~/google-cloud-sdk/path.bash.inc'
    bass source '~/google-cloud-sdk/path.bash.inc'
end

# source asdf
sourceadd ~/.asdf/asdf.fish

if type -q direnv
    direnv hook fish | source
end

# Source completions. Somehow when re-entering fish, such as in tmux, or just do `fish` again,
# the completions under ~/.config/fish/completions are not used. Only directory completions become available.
### for f in ~/.config/fish/completions/*.fish
###     source $f
### end

# github copilot cli
if type -q github-copilot-cli
    alias '@'='github-copilot-cli what-the-shell'
    alias '@git'='github-copilot-cli git-assist'
    alias '@gh'='github-copilot-cli gh-assist'
else
    npm install -g @githubnext/github-copilot-cli || true
end
