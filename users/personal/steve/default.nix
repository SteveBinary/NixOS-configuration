{ pkgs, pkgs-stable, programs, ... }:

{
  imports = with programs; [
    bat
    direnv
    fzf
    helix
    kde-connect
    kitty
    mqtt-explorer
    shells
    tmux
    virt-manager-extra
    vscode
    zellij
    (import git { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })

    ./home-files.nix
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

    preferXdgDirectories = true;
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
