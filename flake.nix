{
  description = "Modular flake-based NixOS-configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    {
      nixosConfigurations = {
        tardis = inputs.nixpkgs.lib.nixosSystem (
          let
            vars = {
              machine = "tardis";
              user.name = "steve";
              user.home = "/home/${vars.user.name}";
              myLib = pkgs: import ./lib { inherit pkgs; };
            };
          in
          rec {
            specialArgs = { inherit inputs vars; };
            modules = [
              ./machines/${vars.machine}
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${vars.user.name} = ./home/${vars.user.name};
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.sharedModules = [
                  ./modules/home-manager
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                ];
              }
            ];
          }
        );
      };
      homeConfigurations = {
        sheilen = inputs.home-manager.lib.homeManagerConfiguration (
          let
            vars = {
              system = "x86_64-linux";
              user.name = "sheilen";
              user.home = "/home/${vars.user.name}";
            };
            pkgs = inputs.nixpkgs.legacyPackages.${vars.system};
            myLib = import ./lib { inherit pkgs; };
          in
          {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs myLib vars; };
            modules = [
              ./home/${vars.user.name}
              ./modules/home-manager
              inputs.sops-nix.homeManagerModules.sops
            ];
          }
        );
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            age
            just
            sops
          ];
        };
      }
    );
}
