{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.programs.zellij;
in
{
  options.my.programs.zellij = {
    enable = lib.mkEnableOption "Enable my Home Manager module for zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      settings = { };
    };
  };
}
