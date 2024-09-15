{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.programs.shells.zsh;
in
{
  options.my.programs.shells.zsh = {
    enable = lib.mkEnableOption "Enable my Home Manager module for zsh";
  };

  config = lib.mkIf cfg.enable {
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
        highlighters = [
          "brackets"
          "pattern"
        ];
        patterns = {
          "rm -rf" = "fg=white,bold,bg=red";
          "sudo " = "fg=green,bold";
        };
      };
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
      initExtraFirst = ''
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

        # if running in Kitty, use the kitten-wrapper for ssh to prevent issues on remote hosts that don't have terminfo for Kitty
        # see: https://wiki.archlinux.org/title/Kitty#Terminal_issues_with_SSH
        [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
      '';
    };
  };
}
