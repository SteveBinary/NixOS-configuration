{ nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, programs }:

{ machine, system, user }:
let

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  specialArgs = { inherit pkgs pkgs-stable nixos-hardware home-manager programs machine system user; };

in
  nixpkgs.lib.nixosSystem {
    inherit specialArgs;
    modules = [
      ../machines/${machine}
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user.name} = ../users/${user.profile}/${user.name};
        home-manager.extraSpecialArgs = specialArgs;
      }
    ];
}
