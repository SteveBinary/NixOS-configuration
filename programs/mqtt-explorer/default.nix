{ noSandbox ? false }:

{ pkgs, ... }:

let
  patchDesktopFile = import ../../lib/patchDesktopFile.nix { inherit pkgs; };
  patched-mqtt-explorer = pkgs.mqtt-explorer.overrideAttrs(finalAttrs: prevAttrs: {
    patches = (prevAttrs.patches or []) ++ [
      ./increase_max_value_hight.patch
    ];
  });
in
{
  home.packages = [
    patched-mqtt-explorer
    (
      if noSandbox then patchDesktopFile {
        pkg = patched-mqtt-explorer;
        appName = "mqtt-explorer";
        from = "^Exec=mqtt-explorer";
        to = "Exec=mqtt-explorer --no-sandbox";
      } else null
    )
  ];
}
