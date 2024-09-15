{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "Meslo" ];
  };

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Meslo"
      ];
    })
  ];
}
