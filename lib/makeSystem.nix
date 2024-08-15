{ inputs }:

{ machine, system, user }:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  specialArgs = { inherit pkgs pkgs-stable inputs machine system user; };
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit specialArgs;
    modules = [
      ../machines/${machine}
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user.name} = ../users/${user.profile}/${user.name};
        home-manager.extraSpecialArgs = specialArgs;
      }
    ];
}
