{ pkgs, pkgs-stable, programs, user, ... }:

{
  imports = with programs; [
    bat
    direnv
    fzf
    helix
    mqtt-explorer
    shells
    zellij

    # TODO: update parameters when secret handling is introduced
    (import git { inherit pkgs; userName = "SteveBinary"; userEmail = "SteveBinary@users.noreply.github.com"; })

    ./home-files.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      # desktop applications

      # terminal applications
      dnsutils
      file
      jq
      lsd
      fastfetch
      tldr
      tree
      yazi
    ];

    username = user.name;
    homeDirectory = "/home/${user.name}";
    preferXdgDirectories = true;
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
