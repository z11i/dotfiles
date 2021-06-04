let
   pkgs = import <nixpkgs> {};
   inherit (pkgs) buildEnv;

in buildEnv {
   name = "home";
   paths = [
      pkgs.bat
      pkgs.coreutils
      pkgs.entr
      pkgs.exa
      pkgs.fd
      pkgs.fzf
      pkgs.gitAndTools.delta
      pkgs.gitAndTools.gitFull
      pkgs.gnupg
      pkgs.htop
      pkgs.jq
      pkgs.kafkacat
      pkgs.libressl
      pkgs.neovim
      pkgs.protobuf
      pkgs.ripgrep
      pkgs.socat
      pkgs.starship
      pkgs.unixtools.watch
      pkgs.zoxide
   ];
}
