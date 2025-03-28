{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.my.nix;
in
{
  options.my.nix = {
    enable = lib.mkEnableOption "Enable my configuration for Nix";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.nixVersions.latest;
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        nixpkgs-stable.flake = inputs.nixpkgs-stable;
      };
      channel.enable = false; # remove nix-channel related tools & configs, as flakes are used for everything
      settings = {
        warn-dirty = false;
        experimental-features = [
          "flakes"
          "nix-command"
        ];
      };
      optimise.automatic = true;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
