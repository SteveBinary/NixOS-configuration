{ pkgs, machine, ... }:

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
          sudo nixos-rebuild switch --flake {{ justfile_directory() }}#${ machine }

      update-flake:
          sudo nix flake update --flake {{ justfile_directory() }}

      update: update-flake switch

      collect-garbage:
          sudo nix-collect-garbage

      collect-garbage-all:
          sudo nix-collect-garbage -d
          nix store optimise

      list-generations:
          sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    '';
  };
}
