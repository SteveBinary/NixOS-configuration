{ pkgs, home-manager, ... }:

{
  imports = [
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/fzf.nix
    ../../programs/git.nix
    ../../programs/micro.nix
    ../../programs/vscode.nix
    ../../programs/zsh.nix
  ];

  home = {
    packages = with pkgs; [
      # desktop applications
      firefox
      kate
      libsForQt5.ksshaskpass
      yakuake

      # terminal applications
      file
      jq
      kdash
      kubectl
      lsd
      neofetch
      tldr
      tree
    ];

    sessionVariables =  {
      EDITOR = "micro";
      SUDO_EDITOR = "$EDITOR";
      VISUAL= "$EDITOR";
      MICRO_CONFIG_HOME = "$HOME/.config/micro";
      DIRENV_LOG_FORMAT = "";
    };

    file."NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./programs/extras/images/folder-nix-snowflake-light.svg
    '';

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
