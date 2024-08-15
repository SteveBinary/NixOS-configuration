{ pkgs, lib, config, ... }:

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
      patchDesktopFile = import ../../lib/patchDesktopFile.nix { inherit pkgs; };
      patched-mqtt-explorer = pkgs.mqtt-explorer.overrideAttrs(finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [
          ./increase_max_value_hight.patch
        ];
      });
    in {
      home.packages = [
        patched-mqtt-explorer
      ] ++ lib.optional cfg.noSandbox (
        patchDesktopFile {
          pkg = patched-mqtt-explorer;
          appName = "mqtt-explorer";
          from = "^Exec=mqtt-explorer";
          to = "Exec=mqtt-explorer --no-sandbox";
        }
      );
    }
  );
}
