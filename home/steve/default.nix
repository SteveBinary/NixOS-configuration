{
  pkgs,
  lib,
  vars,
  ...
}:

{
  imports = [
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
    virt-manager-extra.enable = true;
    zed-editor.enable = true;
    zellij.enable = true;
  };

  my.services = {
    kde-connect.enable = true;
    nextcloud-client.enable = true;
  };

  home = {
    packages = with pkgs; [
      # desktop applications
      bitwarden-desktop
      bottles
      element-desktop
      firefox
      handbrake
      haruna
      inkscape
      jetbrains.rust-rover
      kdePackages.kdepim-addons
      kdePackages.ksystemlog
      libreoffice-qt6-fresh
      localsend
      obsidian
      protonmail-bridge-gui
      signal-desktop
      thunderbird
      ytdownloader

      # issue: https://github.com/nix-community/home-manager/issues/5173
      # original: https://github.com/NixOS/nixpkgs/issues/254265
      # using this workaround: https://discourse.nixos.org/t/home-manager-collision-with-app-lib/51969/2
      (lib.hiPrio rustdesk-flutter)

      # spellchecking and hyphenation, mostly for LibreOffice
      hunspell
      hunspellDicts.de_DE
      hyphenDicts.de_DE

      # games
      oh-my-git
      superTux
      superTuxKart

      # terminal applications
      dnsutils
      dos2unix
      exiftool
      file
      imagemagick
      jq
      lsd
      fastfetch
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      tldr
      tree
      yazi
      yq
    ];

    username = vars.user.name;
    homeDirectory = vars.user.home;
    preferXdgDirectories = true;
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
