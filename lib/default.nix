{ pkgs, inputs, ... }:

{
  makeHome = import ./makeHome.nix { inherit pkgs inputs; };
  makeSystem = import ./makeSystem.nix { inherit pkgs inputs; };
  stringUtils = import ./stringUtils.nix { inherit pkgs inputs; };
  patchDesktopFile = import ./patchDesktopFile.nix { inherit pkgs inputs; };
}
