{
  description = "Modular flake-based NixOS-configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }:
  let
    makeSystem = import ./lib/makeSystem.nix { inherit nixpkgs nixpkgs-stable nixos-hardware home-manager; };
  in {
    nixosConfigurations = {
      tardis = makeSystem {
        machine = "tardis";
        system = "x86_64-linux";
        user = "steve";
      };
    };
  };
}
