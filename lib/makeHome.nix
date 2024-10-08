{ inputs, ... }:

{ system, user }:

let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  myLib = import ./default.nix { inherit pkgs inputs; };

  specialArgs = {
    inherit
      pkgs
      pkgs-stable
      myLib
      inputs
      system
      user
      ;
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = specialArgs;
  modules = [
    inputs.sops-nix.homeManagerModules.sops
    ../users/${user.profile}/${user.name}
  ];
}
