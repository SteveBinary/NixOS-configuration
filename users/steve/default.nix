{ pkgs, pkgs-stable, ... }:

{
  imports = [
    ../../programs/bash.nix
    ../../programs/direnv.nix
    ../../programs/fzf.nix
    ../../programs/helix.nix
    ../../programs/tmux.nix
    ../../programs/vscode.nix
    ../../programs/zsh.nix
    (import ../../programs/git.nix { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })
  ];

  home = {
    packages = with pkgs; [
      # desktop applications
      firefox
      kate
      yakuake

      # terminal applications
      file
      jq
      kdash
      kubectl
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