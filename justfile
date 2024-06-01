default_machine := `hostname`

default:
    @just --version && just --list --unsorted && just --evaluate --unsorted

config-switch machine=default_machine:
    sudo nixos-rebuild switch --flake {{ justfile_directory() }}#{{ machine }}

flake-update:
    sudo nix flake update {{ justfile_directory() }}

update-system: flake-update config-switch

collect-garbage *args:
    sudo nix-collect-garbage {{ args }}

list-generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
