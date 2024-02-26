{
  description = "Modular flake-based NixOS-configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, ... }: {
    nixosConfigurations = {
      tardis = nixpkgs.lib.nixosSystem (import ./hosts/tardis/nixos-system.nix {
        hostName = "tardis";
        inherit nixpkgs nixpkgs-stable home-manager;
      });
    };
  };
}
