{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (
      mqtt-explorer.overrideAttrs(finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [
          ./increase_max_value_hight.patch
        ];
      })
    )
  ];
}
