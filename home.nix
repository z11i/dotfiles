let
   pkgs = import <nixpkgs> {};
   inherit (pkgs) buildEnv;

in buildEnv {
   name = "home";
   paths = [
      pkgs.bat
      pkgs.coreutils
      pkgs.du-dust
      pkgs.entr
      pkgs.exa
      pkgs.fd
      pkgs.fzf
      pkgs.gitAndTools.delta
      pkgs.gitAndTools.gitFull
      pkgs.gnupg
      pkgs.htop
      pkgs.jq
      pkgs.libressl
      pkgs.neovim
      pkgs.protobuf
      pkgs.ripgrep
      pkgs.socat
      pkgs.starship
      pkgs.tmux
      pkgs.unixtools.watch
      pkgs.zoxide
   ];
}
