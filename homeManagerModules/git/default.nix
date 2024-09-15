{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.programs.git;
in
{
  options.my.programs.git = {
    enable = lib.mkEnableOption "Enable my Home Manager module for git";
    userName = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
    userEmail = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
    askpass = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
    includes = lib.mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.anything;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        init.defaultbranch = "main";
        core.askpass = lib.mkIf (cfg.askpass != null) cfg.askpass;
      };
      includes = cfg.includes;
    };
  };
}
