{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../../homeManagerModules
    ./home-files.nix
  ];

  my.programs = {
    bat.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    git = {
      enable = true;
      userName = "SteveBinary";
      userEmail = "SteveBinary@users.noreply.github.com";
      askpass = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };
    helix.enable = true;
    kitty.enable = true;
    oh-my-posh.enable = true;
    shells = {
      bash.enable = true;
      zsh.enable = true;
    };
    tmux.enable = true;
    virt-manager-extra.enable = true;
    zellij.enable = true;
  };

  my.services = {
    kde-connect.enable = true;
  };

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
      # kdePackages.neochat # NeoChat uses libolm which is deprecated, investigate later
      kdePackages.yakuake
      libreoffice-qt6-fresh
      localsend
      obsidian
      protonmail-bridge-gui
      # rustdesk # change to rustdesk-flutter when the collisions with LocalSend related to Flutter are resolved, see https://github.com/NixOS/nixpkgs/issues/254265
      signal-desktop
      thunderbird

      # terminal applications
      dos2unix
      file
      jq
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
