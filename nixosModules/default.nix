{ pkgs, ... }:

{
  imports = [
    ./common-utilities
    ./desktops
    ./nix
    ./virtualisation
  ];
}
