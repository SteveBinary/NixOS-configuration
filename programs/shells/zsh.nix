{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history = {
      size = 5000;
      save = 5000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };
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
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh" ]]; then
        source "$${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$${(%):-%n}.zsh"
      fi

      # colors for the default completion menu
      zstyle ':completion:*' list-colors "$${(s.:.)LS_COLORS}"
    '';
    initExtra = ''
      # extras for history
      HISTDUP=erase
      setopt APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_FIND_NO_DUPS

      # replace the default completion menu by fzf
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:*' fzf-preview 'ls --color $realpath'

      # apply p10k config which is stored in the NixOS-configuration git directory
      source "$HOME/NixOS-configuration/programs/shells/p10k.zsh"
    '';
  };
}
