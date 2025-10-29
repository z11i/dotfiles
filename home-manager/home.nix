{ pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "z11i";
  home.homeDirectory = "/Users/z11i";

  # Allow unfree packages selectively
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "claude-code"
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Core utilities
    pkgs.bat               # Colorful cat alternative with syntax highlighting
    pkgs.cacert            # CA certificates bundle
    pkgs.coreutils         # GNU core utilities
    pkgs.du-dust           # Visual disk usage analyzer (intuitive du alternative)
    pkgs.eza               # Modern ls replacement with colors and icons
    pkgs.fd                # Fast find alternative
    pkgs.findutils         # GNU find, xargs, locate
    pkgs.ripgrep           # Fast recursive grep (rg)
    pkgs.wget              # File downloader
    pkgs.zoxide            # Smarter cd command that learns your habits

    # File management
    pkgs.yazi              # Modern TUI file manager with image previews

    # Development tools
    pkgs.claude-code       # Claude AI coding assistant (unfree)
    pkgs.gh                # GitHub CLI
    pkgs.lazygit           # Terminal UI for git
    pkgs.universal-ctags   # Code indexing for editors

    # Editors
    pkgs.helix             # Modern modal editor with built-in LSP
    pkgs.neovim            # Primary terminal editor

    # Git tools
    pkgs.gitAndTools.delta       # Syntax-highlighting git diff pager
    pkgs.gitAndTools.difftastic  # Structural diff tool
    pkgs.gitAndTools.gitFull     # Git with all optional features

    # Shell & terminal
    pkgs.entr              # Run commands when files change (live reload)
    pkgs.fzf               # Fuzzy finder for command-line
    pkgs.starship          # Customizable shell prompt
    pkgs.unixtools.watch   # Execute program periodically

    # Data processing
    pkgs.jq                # JSON processor
    pkgs.xan               # CSV processing toolkit
    pkgs.yq-go             # YAML/XML/TOML processor (Go version)

    # Security & networking
    pkgs.gnupg             # GPG encryption
    pkgs.libressl          # TLS/SSL toolkit
    pkgs.socat             # Multipurpose relay for network connections

    # System tools
    pkgs.gnugrep           # GNU grep
    pkgs.gnused            # GNU sed
    pkgs.htop              # Interactive process viewer
    pkgs.nix               # Nix package manager

    # Language-specific
    pkgs.pgcli             # Postgres CLI with autocomplete
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/z11i/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
