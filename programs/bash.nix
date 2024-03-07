{ machine, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    shellAliases = import ./extras/shell-aliases.nix { inherit machine; };
  };
}
