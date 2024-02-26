{ pkgs, hostName, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;
    history.path = "$HOME/.zsh/zsh_history";
    shellAliases = import ./extras/shell-aliases.nix { inherit hostName; };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtraFirst = ''export ZSH_COMPDUMP="$HOME/.zsh/zcompdump"'';
    initExtra = ''source "$HOME/NixOS-configuration/programs/extras/p10k.zsh"'';
  };
}
