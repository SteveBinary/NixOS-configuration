{
  pkgs,
  inputs,
  config,
  vars,
  ...
}:

{
  imports = [
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
          if [ -z "$ZSH_VERSION" ]; then exec ${config.home.homeDirectory}/.nix-profile/bin/zsh; fi
        '';
      };
      zsh.enable = true;
    };
    zed-editor.enable = true;
    zellij.enable = true;
  };

  home = {
    packages = with pkgs; [
      # desktop applications
      jetbrains.idea-ultimate
      jetbrains.rider
      jetbrains.rust-rover
      keepass
      vlc

      # terminal applications
      dnsutils
      fastfetch
      file
      hexyl
      jq
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      lsd
      minikube
      parallel
      ripgrep
      tldr
      tree
      yazi
      yq
    ];

    sessionVariables = {
      GRADLE_USER_HOME = "${config.home.homeDirectory}/.gradle";
    };

    username = vars.user.name;
    homeDirectory = vars.user.home;
    preferXdgDirectories = true;
    stateVersion = "25.05";
  };

  sops.secrets = {
    git_user_information = { };
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
  };

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-stable.flake = inputs.nixpkgs-stable;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  news.display = "silent";
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
