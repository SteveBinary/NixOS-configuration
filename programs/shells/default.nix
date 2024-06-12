{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./oh-my-posh.nix
  ];

  home.shellAliases = import ./shell-aliases.nix;
}
