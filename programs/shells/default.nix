{ machine, ... }:

{
  imports = [
    ./bash.nix
    ./zsh.nix
  ];

  home.shellAliases = import ./shell-aliases.nix { inherit machine; };
}

