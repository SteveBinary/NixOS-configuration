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
