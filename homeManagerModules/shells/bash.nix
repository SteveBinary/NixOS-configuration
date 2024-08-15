{ pkgs, lib, config, ... }:

let
  cfg = config.my.programs.shells.bash;
in
{
  options.my.programs.shells.bash = {
    enable = lib.mkEnableOption "Enable my Home Manager module for bash";
    bashrcExtra = lib.mkOption {
      default = "";
      type = lib.types.lines;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [ "ignoredups" "ignorespace" ];
      bashrcExtra = cfg.bashrcExtra;
    };
  };
}
