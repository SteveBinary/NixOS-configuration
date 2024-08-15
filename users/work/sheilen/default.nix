{ pkgs, pkgs-stable, config, programs, user, ... }:

{
  imports = with programs; [
    bat
    direnv
    fzf
    helix
    shells
    zellij

    (import mqtt-explorer { noSandbox = true; })
    (import git {
      askpass = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";
      includes = [
        { path = config.sops.secrets.git_user_information.path; }
      ];
    })

    ./fonts.nix
    ./home-files.nix
  ];

  programs.bash.bashrcExtra = ''
    # changing the default shell for a user is not allowed, so this workaround is needed
    if [ -z "$ZSH_VERSION" ]; then exec /home/${user.name}/.nix-profile/bin/zsh; fi
  '';

  home = {
    packages = with pkgs; [
      # desktop applications
      floorp
      jetbrains.idea-ultimate
      jetbrains.rust-rover
      keepass

      # terminal applications
      dnsutils
      fastfetch
      file
      jq
      kubectl
      kubectx
      kubernetes-helm
      lsd
      tldr
      tree
      yazi
    ];

    sessionVariables = {
      GRADLE_USER_HOME = "/home/${user.name}/.gradle";
    };

    username = user.name;
    homeDirectory = "/home/${user.name}";
    preferXdgDirectories = true;
    stateVersion = "24.11";
  };

  sops.secrets = {
    git_user_information = {};
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
