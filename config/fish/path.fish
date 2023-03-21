# homebrew
path_append /usr/local/sbin
path_append /opt/homebrew/bin

########## Below is prepend, priority goes in ascending order #########
# nix
path_prepend ~/.nix-profile/bin

# node
path_prepend ~/.node_modules/bin

# golang
set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
path_prepend $GOBIN

# rust
path_prepend ~/.cargo/bin

# dotfiles
path_prepend ~/.local/bin

# coreutils
set -l coreutils /usr/local/opt/coreutils
path_prepend $coreutils/libexec/gnubin
