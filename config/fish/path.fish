# dotfiles
path_prepend ~/bin
path_prepend ~/.local/bin

# homebrew
path_append /usr/local/sbin
path_append /opt/homebrew/bin

# coreutils
set -l coreutils /usr/local/opt/coreutils
path_prepend $coreutils/libexec/gnubin

# golang
set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
path_prepend $GOBIN

# rust
path_prepend ~/.cargo/bin
