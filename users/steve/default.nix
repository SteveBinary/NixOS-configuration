{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../programs/direnv.nix
    ../../programs/fzf.nix
    ../../programs/helix.nix
    ../../programs/kde-connect.nix
    ../../programs/tmux.nix
    ../../programs/virt-manager-extra.nix
    ../../programs/vscode.nix
    ../../programs/shells
    (import ../../programs/git.nix { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })
  ];

  home = {
    packages = with pkgs; [
      # desktop applications
      bitwarden-desktop
      brave
      firefox
      jetbrains.idea-ultimate
      kdePackages.kate
      kdePackages.neochat
      kdePackages.yakuake
      libreoffice-qt
      localsend
      protonmail-bridge-gui
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

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
