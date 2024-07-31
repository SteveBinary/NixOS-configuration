{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGM Nerd Font";
      size = 13;
    };
    theme = "Catppuccin-Mocha";
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };
  };
}
