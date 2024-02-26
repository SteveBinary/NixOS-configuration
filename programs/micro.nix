{
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      colorscheme = "material-tc";
      mkparents = true;
      savecursor = true;
      saveundo = true;
      tabhighlight = true;
      tabsize = 2;
      tabstospaces = true;
    };
  };

  home.sessionVariables =  {
    EDITOR = "micro";
    SUDO_EDITOR = "$EDITOR";
    VISUAL= "$EDITOR";
    MICRO_CONFIG_HOME = "$HOME/.config/micro";
  };
}
