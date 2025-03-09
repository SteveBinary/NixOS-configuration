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
    ./nextcloud-client
    ./shells
    ./tmux
    ./virt-manager-extra
    ./zed
    ./zellij
  ];
}
