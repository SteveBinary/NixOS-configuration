{
  pkgs,
  inputs,
  user,
  ...
}:

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
      @default:
          just --version
          just --list --unsorted

      format:
          nix fmt *.nix --no-update-lock-file

      switch:
          home-manager switch --flake {{ justfile_directory() }}#${user.profile}-${user.name}

      update-flake:
          nix flake update --flake {{ justfile_directory() }}

      update-desktop-entries:
          sudo /usr/bin/update-desktop-database

      update: update-flake switch

      collect-garbage:
          nix-collect-garbage

      collect-garbage-all:
          nix-collect-garbage -d
          nix store optimise
    '';
  };
}
