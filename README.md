# Script to set up my working environment

```
git clone --recurse-submodules https://github.com/z11i/dotfiles.git
cd dotfiles/
./setup -h
```

Note that although `--help` says negative options are available, such as `--nogit`, the `[no]` options do not overwrite `--all`. This is due to shflags doesn't distinguish missing values from default values.


## SSH and GPG
```shell
# ssh-agent start
eval (ssh-agent -c)
# add ssh key to ssh-agent
ssh-add ~/.ssh/id_ed25519
# list gpg keys
gpg --list-secret-keys --keyid-format LONG
# export gpg armor public key
gpg --armor --export B29224787DF450CA
# set env var
set -x GPG_TTY (tty)
```