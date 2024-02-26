{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "SteveBinary";
    userEmail = "SteveBinary@users.noreply.github.com";
    extraConfig = {
      init.defaultbranch = "main";
      core.askpass = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";
    };
  };
}
