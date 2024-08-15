{ pkgs, ... }:

{
  imports = [
    ./bat
    ./direnv
    ./fzf
    ./git
    ./helix
    ./kde-connect
    ./kitty
    ./mqtt-explorer
    ./shells
    ./tmux
    ./virt-manager-extra
    ./zellij
  ];
}
