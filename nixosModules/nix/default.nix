{ pkgs, lib, config, ... }:

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
      settings = {
        experimental-features = [ "flakes" "nix-command" ];
        auto-optimise-store = true;
        warn-dirty = false;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
