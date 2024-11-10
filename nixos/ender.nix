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
    # General
    inputs.zen-browser.packages."${system}".specific
    kdePackages.filelight
    spotify-qt
    discord
    neofetch

    # Work
    jetbrains.idea-ultimate
    graalvm-ce
    onlyoffice-bin
    aseprite
    reaper
    blockbench

    # Gaming
    protonup-qt
    prismlauncher

    # Essential
    mpv

    # Misc

    # Temop
    gitg
    gpu-viewer
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    themeFile = "tokyo_night_moon";
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 10;
    };
    extraConfig = ''
      confirm_os_window_close 0
      background_opacity 0.2
      background_blur 1
      window_padding_width 8
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    /*
         plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];
    */
    history = {
      size = 10000;
      save = 10000;
      share = true;
      append = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
    };

    shellAliases = {
      update = "~/dotfiles/rebuild.sh";
      nv = "nvim";
      v = "nvim";
      ls = "ls --color";
    };
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
    # zstyle ':completion:*' list-colors "${s.:. LS_COLORS}"
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${pkgs.oh-my-posh}/share/oh-my-posh/themes/dracula.omp.json"));
  };

  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "TheEnderCore";
        email = "theendercore@gmail.com";
      };
    };
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
