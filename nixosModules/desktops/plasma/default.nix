{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktop.plasma;
in
{
  options.my.desktop.plasma = {
    enable = lib.mkEnableOption "Enable my configuration for the KDE Plasma desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
    };
    environment.systemPackages = with pkgs; [
      # mostly for the Info Center app to display all sorts of information
      aha
      clinfo
      glxinfo
      hdparm
      lshw
      lsscsi
      pciutils
      usbutils
      vulkan-tools
      wayland-utils
    ];
  };
}
