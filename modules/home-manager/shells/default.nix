{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.programs.shells;
in
{

  imports = [
    ./bash.nix
    ./zsh.nix
    ./oh-my-posh.nix
  ];

  options.my.programs.shells = {
    fancyLS = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
  };

  config = {
    home.packages = lib.optional cfg.fancyLS pkgs.lsd;
    home.shellAliases =
      import ./common-shell-aliases.nix
      // lib.optionalAttrs cfg.fancyLS {
        l = "lsd --long --group-directories-first";
        ls = "lsd --long --group-directories-first";
        la = "lsd --all --long --group-directories-first";
        ll = "lsd --all --long --group-directories-first";
      };
  };
}
