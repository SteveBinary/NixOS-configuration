{ config, ... }:

{
  home.file = {
    ".hushlogin".text = ""; # disable the login banner; also disables the warning "groups: cannot find name for group ID ..." because of LDAP

    "Projects/.directory".text = ''
      [Desktop Entry]
      Icon=folder-script
    '';

    "NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./assets/images/folder-nix-snowflake-light.svg
    '';

    "NixOS-configuration/justfile".text = ''
      set shell := ["zsh", "-cu"]

      @default:
          just --version
          just --list --unsorted

      format:
          nix fmt --no-update-lock-file *.nix **/*.nix

      switch:
          home-manager switch --flake {{ justfile_directory() }}#${config.home.username}

      update-flake:
          nix flake update --flake {{ justfile_directory() }}

      update-desktop-entries:
          sudo /usr/bin/update-desktop-database

      update: update-flake switch

      collect-garbage:
          #!/usr/bin/env zsh
          before=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
          nix-collect-garbage
          after=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
          echo "=================================================="
          echo "Effect of garbage collection on disk usage"
          echo "  Before: $before"
          echo "  After:  $after"

      collect-garbage-all:
          #!/usr/bin/env zsh
          before=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
          nix-collect-garbage -d
          nix store optimise
          after=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
          echo "=================================================="
          echo "Effect of garbage collection on disk usage"
          echo "  Before: $before"
          echo "  After:  $after"
    '';
  };
}
