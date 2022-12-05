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
      pkgs.exa
      pkgs.fd
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
      pkgs.mosh
      pkgs.neovim
      pkgs.nix
      pkgs.protobuf
      pkgs.ripgrep
      pkgs.socat
      pkgs.starship
      pkgs.tmux
      pkgs.universal-ctags
      pkgs.unixtools.watch
      pkgs.yq
      pkgs.zoxide
   ];
}
