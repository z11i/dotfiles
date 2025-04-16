########## Below is prepend, priority goes in ascending order #########
# nix
path_prepend ~/.nix-profile/bin

# homebrew
path_prepend /usr/local/sbin
path_prepend /opt/homebrew/bin

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
path_prepend ~/.local/bin/git-scripts

# coreutils
set -l coreutils /usr/local/opt/coreutils
path_prepend $coreutils/libexec/gnubin

# kafka
path_append /opt/kafka/bin

# kubectl krew
path_append ~/.krew/bin
