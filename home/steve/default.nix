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

  my.desktops.plasma.enable = true;

  my.programs = {
    development.editors = {
      helix.enable = true;
      zed.enable = true;
    };
    git = {
      enable = true;
      userName = "SteveBinary";
      userEmail = "SteveBinary@users.noreply.github.com";
      askpass = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };
    shells = {
      fancyLS = true;
      clipboardAliasesBackend = "Wayland";
      bash.enable = true;
      zsh.enable = true;
    };
    kitty.enable = true;
    oh-my-posh.enable = true;
    zellij.enable = true;
    bat.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    utilities.enable = true;
    virt-manager-extra.enable = true;
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
      czkawka-full
      element-desktop
      firefox
      handbrake
      haruna
      inkscape
      libreoffice-qt6-fresh
      localsend
      obsidian
      protonmail-bridge-gui
      signal-desktop-source
      thunderbird
      ytdownloader

      # issue: https://github.com/nix-community/home-manager/issues/5173
      # original: https://github.com/NixOS/nixpkgs/issues/254265
      # using this workaround: https://discourse.nixos.org/t/home-manager-collision-with-app-lib/51969/2
      # TODO: (lib.hiPrio rustdesk-flutter)

      # spellchecking and hyphenation, mostly for LibreOffice
      hunspell
      hunspellDicts.de_DE
      hyphenDicts.de_DE

      # games
      oh-my-git
      superTux
      superTuxKart

      # terminal applications
      dos2unix
      exiftool
      imagemagick
    ];

    username = vars.user.name;
    homeDirectory = vars.user.home;
    preferXdgDirectories = true;
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
