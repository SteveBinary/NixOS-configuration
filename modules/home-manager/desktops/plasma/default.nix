{
  lib,
  config,
  ...
}:

#### Getting the app IDs
# run   'ls /run/current-system/sw/share/applications'         for programs installed via the system config
# run   'ls /etc/profiles/per-user/steve/share/applications'   for programs installed via Home Manager
# run   'ls /run/current-system/sw/share/plasma/plasmoids'     for the plasmoids
# there is more in '/run/current-system/sw/share/plasma'

let
  cfg = config.my.desktops.plasma;
in
{
  options.my.desktops.plasma = {
    enable = lib.mkEnableOption "Enable my Home Manager module for direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = true;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        theme = "breeze-dark";
      };
      fonts.fixedWidth = {
        family = "FiraCode Nerd Font";
        pointSize = 10;
      };
      krunner.position = "center";
      kwin.effects.shakeCursor.enable = false;
      input.touchpads = [
        {
          enable = true;
          name = "PIXA3854:00 093A:0274 Touchpad";
          vendorId = "093a";
          productId = "0274";
          tapToClick = true;
          disableWhileTyping = false;
          middleButtonEmulation = false;
          naturalScroll = true;
          pointerSpeed = 0.2; # TODO: set to 0.6 when accelerationProfile can be set to none
          # accelerationProfile = "none"; # TODO: wait for PR https://github.com/nix-community/plasma-manager/pull/478
        }
      ];
      configFile = {
        kdeglobals = {
          General = {
            TerminalApplication = "kitty";
            TerminalService = "kitty.desktop";
          };
          KDE.AnimationDurationFactor = 0.25;
        };
        krunnerrc = {
          Plugins = {
            browserhistoryEnabled = false;
            browsertabsEnabled = false;
            krunner_appstreamEnabled = false;
            krunner_katesessionsEnabled = false;
            krunner_konsoleprofilesEnabled = false;
          };
        };
        kwinrc = {
          Effect-overview.BorderActivate = 9;
        };
      };
      shortcuts = {
        "kwin"."Window Maximize" = "Meta+Up";
        "services/kitty.desktop"."_launch" = "Ctrl+Alt+T";
      };
      panels = [
        {
          screen = "all";
          location = "bottom";
          floating = true;
          widgets = [
            {
              kickoff.icon = "nix-snowflake-white";
            }
            {
              iconTasks.launchers = [
                "applications:firefox.desktop"
                "applications:thunderbird.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.microphone"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.battery"
                ];
                hidden = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.clipboard"
                  "Nextcloud"
                  "Proton"
                ];
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                date.format.custom = "dd.MM.yyyy";
                time.format = "24h";
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];
    };
  };
}
