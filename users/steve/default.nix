{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../programs/bat
    ../../programs/direnv
    ../../programs/fzf
    ../../programs/helix
    ../../programs/kde-connect
    ../../programs/kitty
    ../../programs/mqtt-explorer
    ../../programs/shells
    ../../programs/tmux
    ../../programs/virt-manager-extra
    ../../programs/vscode
    ../../programs/zellij
    (import ../../programs/git { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })
  ];

  home = {
    packages = with pkgs; [
      # desktop applications
      bitwarden-desktop
      bottles
      brave
      firefox
      handbrake
      haruna
      jetbrains.idea-ultimate
      kdePackages.isoimagewriter
      kdePackages.kate
      kdePackages.kdepim-addons
      kdePackages.ksystemlog
      kdePackages.merkuro
      kdePackages.neochat
      kdePackages.yakuake
      libreoffice-qt6-fresh
      localsend
      obsidian
      protonmail-bridge-gui
      rustdesk # change to rustdesk-flutter when the collisions with LocalSend related to Flutter are resolved
      signal-desktop
      thunderbird

      # terminal applications
      dos2unix
      file
      jq
      kdash
      lsd
      fastfetch
      tldr
      tree
      yazi
    ];

    file."NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./programs/extras/images/folder-nix-snowflake-light.svg
    '';

    file."Projects/.directory".text = ''
      [Desktop Entry]
      Icon=folder-script
    '';

    preferXdgDirectories = true;
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
