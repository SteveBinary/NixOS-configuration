{
  description = "Modular flake-based NixOS-configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
  };

  outputs = inputs@{ self, ... }:
  let
    myLib = import ./lib { inherit (self) pkgs; inherit inputs; };

    devShellSupportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachDevShellSupportedSystem = f: inputs.nixpkgs.lib.genAttrs devShellSupportedSystems (system: f {
      pkgs = import inputs.nixpkgs { inherit system; };
    });
  in {
    nixosConfigurations = {
      tardis = myLib.makeSystem {
        machine = "tardis";
        system = "x86_64-linux";
        user = {
          name = "steve";
          profile = "personal";
        };
      };
    };
    homeConfigurations = {
      work-sheilen = myLib.makeHome {
        system = "x86_64-linux";
        user = {
          name = "sheilen";
          profile = "work";
        };
      };
    };
    devShells = forEachDevShellSupportedSystem ({ pkgs }: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          age
          just
          sops
        ];
      };
    });
  };
}
