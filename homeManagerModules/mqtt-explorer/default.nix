{ pkgs, lib, config, myLib, ... }:

let
  cfg = config.my.programs.mqtt-explorer;
in
{
  options.my.programs.mqtt-explorer = {
    enable = lib.mkEnableOption "Enable my Home Manager module for mqtt-explorer";
    noSandbox = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable (
    let
      patched-mqtt-explorer = pkgs.mqtt-explorer.overrideAttrs(finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [
          ./increase_max_value_hight.patch
        ];
      });
    in {
      home.packages = [
        patched-mqtt-explorer
      ] ++ lib.optional cfg.noSandbox (
        myLib.patchDesktopFile {
          pkg = patched-mqtt-explorer;
          appName = "mqtt-explorer";
          from = "^Exec=mqtt-explorer";
          to = "Exec=mqtt-explorer --no-sandbox";
        }
      );
    }
  );
}
