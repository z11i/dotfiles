let
   pkgs = import <nixpkgs> {};
   inherit (pkgs) buildEnv;

in buildEnv {
   name = "home";
   paths = [
      pkgs.bat
      pkgs.bit
      pkgs.cacert
      pkgs.coreutils
      pkgs.du-dust
      pkgs.entr
      pkgs.exercism
      pkgs.eza
      pkgs.fd
      pkgs.findutils
      pkgs.fzf
      pkgs.gitAndTools.delta
      pkgs.gitAndTools.difftastic
      pkgs.gitAndTools.gitFull
      pkgs.gnugrep
      pkgs.gnupg
      pkgs.gnused
      pkgs.htop
      pkgs.jq
      pkgs.lazygit
      pkgs.libressl
      pkgs.luarocks
      pkgs.mosh
      pkgs.neovim
      pkgs.nix
      pkgs.pgcli
      pkgs.ripgrep
      pkgs.socat
      pkgs.starship
      pkgs.tmux
      pkgs.universal-ctags
      pkgs.unixtools.watch
      pkgs.vivid
      pkgs.wget
      pkgs.yq-go
      pkgs.zoxide
   ];
}
