{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config.global.warn_timeout = "10s"; # https://github.com/direnv/direnv/blob/master/man/direnv.toml.1.md
  };

  home.sessionVariables =  {
    DIRENV_LOG_FORMAT = "";
  };
}
