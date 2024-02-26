{ nixpkgs, nixpkgs-stable, home-manager, hostName, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  specialArgs = { inherit pkgs pkgs-stable home-manager hostName; };
in
{
  inherit specialArgs;

  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.steve = ./home.nix;
      home-manager.extraSpecialArgs = specialArgs;
    }
  ];
}
