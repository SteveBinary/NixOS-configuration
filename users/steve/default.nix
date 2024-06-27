{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../programs/bat.nix
    ../../programs/direnv.nix
    ../../programs/fzf.nix
    ../../programs/helix.nix
    ../../programs/kde-connect.nix
    ../../programs/shells
    ../../programs/tmux.nix
    ../../programs/virt-manager-extra.nix
    ../../programs/vscode.nix
    (import ../../programs/git.nix { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })
  ];

  home = {
    packages = with pkgs; [
      # desktop applications
      bitwarden-desktop
      brave
      dos2unix
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
      file
      jq
      kdash
      lsd
      fastfetch
      tldr
      tree
    ];

    file."NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./programs/extras/images/folder-nix-snowflake-light.svg
    '';

    file."Projects/.directory".text = ''
      [Desktop Entry]
      Icon=folder-script
    '';

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
