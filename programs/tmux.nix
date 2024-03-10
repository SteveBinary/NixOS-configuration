{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    mouse = true;
    prefix = "C-Space";

    # start index for windows and panes at 1 instead of 0
    baseIndex = 1;

    # vim bindings for navigation
    customPaneNavigationAndResize = true;
    keyMode = "vi";

    # enable colored prompt
    terminal = "xterm-256color";

    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      # enable 24-Bit color support
      set-option -sa terminal-overrides ",xterm*:Tc"

      # open panes in the current working directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
