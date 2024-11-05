{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "ender";
  home.homeDirectory = "/home/ender";

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # apps
    kdePackages.filelight
    discord
    prismlauncher
    onlyoffice-bin
    spotify-qt
    aseprite

    neofetch

    graalvm-ce

    protonup-qt
    inputs.zen-browser.packages."${system}".specific

    # Temop
    gitg
  ];

  programs.zsh = {
    enable = true;
    #enableCompletion = true;
    #autosuggestion.enable = true;
    #syntaxHighlighting.enable = true;
    shellAliases = {
      update = "~/dotfiles/rebuild.sh";
    };
  };
  programs.kitty = {
    enable = true;
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.;
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
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #  /etc/profiles/per-user/ender/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
