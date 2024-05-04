{ pkgs, ... }:

{
  home.sessionVariables = {
    ZSH_TMUX_AUTOSTART = "true"; # used by Oh My ZSH tmux plugin
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history.path = ".config/zsh/history";
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" "pattern" ];
      patterns = {
        "rm -rf" = "fg=white,bold,bg=red";
        "sudo " = "fg=green,bold";
      };
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gradle"
        "history"
        "kubectl"
        "ripgrep"
        "rust"
        "tmux"
      ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''source "$HOME/NixOS-configuration/programs/shells/p10k.zsh"'';
  };
}
