# dotfiles
pathadd ~/bin
pathadd ~/.local/bin

# homebrew
pathadd /usr/local/sbin
pathadd /opt/homebrew/bin

# coreutils
set -l coreutils /usr/local/opt/coreutils
pathadd $coreutils/libexec/gnubin

# golang
set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
pathadd $GOBIN

# rust
pathadd ~/.cargo/bin
