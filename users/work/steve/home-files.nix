{ pkgs, user, ... }:

{
  home.file = {
    "Projects/.directory".text = ''
      [Desktop Entry]
      Icon=folder-script
    '';

    "NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./programs/extras/images/folder-nix-snowflake-light.svg
    '';

    "NixOS-configuration/justfile".text = ''
      @default:
          just --version
          just --list --unsorted

      switch:
          home-manager switch --flake {{ justfile_directory() }}#${ user.profile }-${ user.name }

      update-flake:
          nix flake update --flake {{ justfile_directory() }}

      update: update-flake switch

      collect-garbage:
          nix-collect-garbage

      collect-garbage-all:
          nix-collect-garbage -d
          nix store optimise
    '';
  };
}
