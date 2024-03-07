{ pkgs, userName, userEmail, ... }:

{
  programs.git = {
    enable = true;
    inherit userName userEmail;
    extraConfig = {
      init.defaultbranch = "main";
      core.askpass = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };
  };
}
