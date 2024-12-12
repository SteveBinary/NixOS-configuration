{
  pkgs,
  pkgs-stable,
  config,
  user,
  ...
}:

{
  imports = [
    ../../../homeManagerModules
    ./fonts.nix
    ./home-files.nix
  ];

  my.programs = {
    bat.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    git = {
      enable = true;
      askpass = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";
      includes = [ { path = config.sops.secrets.git_user_information.path; } ];
    };
    helix.enable = true;
    mqtt-explorer = {
      enable = true;
      noSandbox = true;
    };
    oh-my-posh.enable = true;
    shells = {
      bash = {
        enable = true;
        bashrcExtra = ''
          # changing the default shell for a user is not allowed, so this workaround is needed
          if [ -z "$ZSH_VERSION" ]; then exec /home/${user.name}/.nix-profile/bin/zsh; fi
        '';
      };
      zsh.enable = true;
    };
    zellij.enable = true;
  };

  home = {
    packages = with pkgs; [
      # desktop applications
      jetbrains.idea-ultimate
      jetbrains.rust-rover
      keepass

      # terminal applications
      dnsutils
      fastfetch
      file
      jq
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      lsd
      parallel
      ripgrep
      tldr
      tree
      yazi
      yq
    ];

    sessionVariables = {
      GRADLE_USER_HOME = "/home/${user.name}/.gradle";
    };

    username = user.name;
    homeDirectory = "/home/${user.name}";
    preferXdgDirectories = true;
    stateVersion = "25.05";
  };

  sops.secrets = {
    git_user_information = { };
  };

  sops = {
    age.keyFile = "/home/${user.name}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
  };

  news.display = "silent";
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
