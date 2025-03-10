{
  pkgs,
  machine,
  user,
  ...
}:

{
  home.file = {
    "Projects/.directory".text = ''
      [Desktop Entry]
      Icon=folder-script
    '';

    "NixOS-configuration/.directory".text = ''
      [Desktop Entry]
      Icon=./assets/images/folder-nix-snowflake-light.svg
    '';

    "Nextcloud/.directory".text = ''
      [Desktop Entry]
      Icon=/home/${user.name}/NixOS-configuration/assets/images/folder-nextcloud-light.svg
    '';

    "NixOS-configuration/justfile".text = # just
      ''
        set shell := ["zsh", "-cu"]

        @default:
            just --version
            just --list --unsorted

        format:
            nix fmt --no-update-lock-file *.nix **/*.nix

        switch:
            sudo nixos-rebuild switch --flake {{ justfile_directory() }}#${machine}

        update-flake:
            sudo nix flake update --flake {{ justfile_directory() }}

        update: update-flake switch

        collect-garbage:
            #!/usr/bin/env zsh
            before=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
            sudo nix-collect-garbage
            after=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
            echo "=================================================="
            echo "Effect of garbage collection on disk usage"
            echo "  Before: $before"
            echo "  After:  $after"

        collect-garbage-all:
            #!/usr/bin/env zsh
            before=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
            sudo nix-collect-garbage -d
            nix store optimise
            after=$(df --human-readable --output=used / | sed 1d | sed "s/[[:space:]]*//")
            echo "=================================================="
            echo "Effect of garbage collection on disk usage"
            echo "  Before: $before"
            echo "  After:  $after"

        list-generations:
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
      '';
  };
}
