{ nixpkgs, nixpkgs-stable, home-manager, programs }:

{ system, user }:
let

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  specialArgs = { inherit pkgs pkgs-stable home-manager programs system user; };

in
  home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = specialArgs;
    modules = [
      ../users/${user.profile}/${user.name}
    ];
  }
