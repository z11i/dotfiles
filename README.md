# Script to set up my working environment

```
git clone --recurse-submodules https://github.com/z11i/dotfiles.git
cd dotfiles/
./setup -h
```

Note that although `--help` says negative options are available, such as `--nogit`, the `[no]` options do not overwrite `--all`. This is due to shflags doesn't distinguish missing values from default values.
