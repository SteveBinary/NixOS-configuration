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
    development = {
      editors = {
        helix.enable = true;
        zed.enable = true;
        jetbrains = {
          defaultVMOptions = {
            minMemory = 2048;
            maxMemory = 16384;
          };
          intellij = {
            enable = true;
            package = pkgs.jetbrains.idea-ultimate;
          };
          rider.enable = true;
          rustrover.enable = true;
        };
      };
      kubernetes.enable = true;
      mqtt-explorer = {
        enable = true;
        noSandbox = true;
      };
    };
    git = {
      enable = true;
      askpass = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";
      includes = [ { path = config.sops.secrets.git_user_information.path; } ];
    };
    shells = {
      fancyLS = true;
      clipboardAliasesBackend = "X11";
      bash = {
        enable = true;
        bashrcExtra = ''
          # changing the default shell for a user is not allowed, so this workaround is needed
          if [ -z "$ZSH_VERSION" ]; then exec ${config.home.homeDirectory}/.nix-profile/bin/zsh; fi
        '';
      };
      zsh.enable = true;
    };
    oh-my-posh.enable = true;
    zellij.enable = true;
    bat.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    utilities.enable = true;
  };

  home = {
    packages = with pkgs; [
      keepass
      vlc
    ];

    sessionVariables = {
      GRADLE_USER_HOME = "${config.home.homeDirectory}/.gradle";
    };

    username = vars.user.name;
    homeDirectory = vars.user.home;
    preferXdgDirectories = true;
    stateVersion = "25.11";
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
