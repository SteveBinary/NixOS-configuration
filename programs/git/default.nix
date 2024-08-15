{ userName ? null, userEmail ? null, askpass ? null, includes ? [] }:

{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = lib.mkIf (userName != null) userName;
    userEmail = lib.mkIf (userEmail != null) userEmail;
    extraConfig = {
      init.defaultbranch = "main";
      core.askpass = lib.mkIf (askpass != null) askpass;
    };
    inherit includes;
  };
}
