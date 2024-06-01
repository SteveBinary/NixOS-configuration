default_machine := `hostname`

@default:
    just --version
    echo "Variables:"
    just --evaluate --unsorted | sed 's/^/    /'
    just --list --unsorted

config-switch machine=default_machine:
    sudo nixos-rebuild switch --flake {{ justfile_directory() }}#{{ machine }}

update-flake:
    sudo nix flake update {{ justfile_directory() }}

update-system: update-flake config-switch

collect-garbage *args:
    sudo nix-collect-garbage {{ args }}

list-generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
