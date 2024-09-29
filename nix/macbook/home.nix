{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "grants";
  home.homeDirectory = "/home/grants";

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
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    obsidian
    (pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        eamodio.gitlens
        mhutchie.git-graph
        mechatroner.rainbow-csv
        hediet.vscode-drawio
      ];
    })
  ];

  # Manage VSCode user settings
  home.file.".config/Code/User/settings.json".text = builtins.toJSON {
    # "files.autoSave" = "afterDelay";
    "window.autoDetectColorScheme" = true;
    "workbench.preferredLightColorTheme" = "Solarized Light";
    "workbench.colorCustomizations" = {
      "[Solarized Light]" = {
        "editor.lineHighlightBackground" = "#00000000";
        "editor.lineHighlightBorder" = "#00000000";
      };
      "[Default Dark Modern]" = {
        "editor.lineHighlightBackground" = "#00000000";
        "editor.lineHighlightBorder" = "#00000000";
      };
    };
    "editor.guides.highlightActiveIndentation" = false;
    "editor.guides.indentation" = false;
    "editor.lineNumbers" = "off";
    "editor.minimap.enabled" = false;
    "editor.occurrencesHighlight" = "off";
    "editor.padding.top" = 20;
    "editor.renderWhitespace" = "trailing";
  };


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
  #  /etc/profiles/per-user/grants/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";  # Or any other theme you prefer
      plugins = [ "git" "docker" "kubectl" ];  # Add any plugins you want
    };
  };

  programs.git = {
    enable = true;

    # Set global username and email
    userName = "GSmithApps";
    userEmail = "14.gsmith.14@gmail.com";
  };

  nixpkgs.config.allowUnfree = true;

}
