{ pkgs, ... }:

let
  stateVersion = "23.11";
  hostName = "dev-vm";
in

{
  home.stateVersion = stateVersion;
  programs.home-manager.enable = true;
 
  home.packages = with pkgs; [
    firefox
    kate
    libsForQt5.ksshaskpass
    jetbrains-toolbox
    yakuake
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "SteveBinary";
      userEmail = "SteveBinary@users.noreply.github.com";
      extraConfig = {
        init.defaultbranch = "main";
        safe.directory = "/etc/nixos";
        core.askpass = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";
      };
    };
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
      ];
      userSettings = {
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true; 
        "terminal.integrated.fontFamily" = "Fira Code";
        "update.mode" = "none";
        "workbench.startupEditor" = "none";
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      autocd = true;
      history.path = "$HOME/.zsh/zsh_history";
      shellAliases = {
        p = "cd ~/projects";
        l = "ls -l";
        ll = "ls -al";
        cat = "bat";
        rm = "echo 'Use trash-put <file/directory> for using the trash. Use \\\\rm <file/directory> if you are sure.'; false";
        flake-edit = "sudo nano /etc/nixos/flake.nix";
        home-config-edit = "sudo nano /etc/nixos/home.nix";
        config-edit = "sudo nano /etc/nixos/configuration.nix";
        config-switch = "sudo nixos-rebuild --flake /etc/nixos#${hostName} switch";
        reboot-now = "sudo reboot now";
        update-packages = "echo 'Updating flake...' && sudo nix flake update /etc/nixos && echo 'Rebuild and switch...' && sudo nixos-rebuild --flake /etc/nixos#${hostName} switch";
        ncg = "sudo nix-collect-garbage";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      initExtraFirst = ''
        export ZSH_COMPDUMP="$HOME/.zsh/zcompdump"
      '';
      initExtra = ''
        source /etc/nixos/extras/powerlevel10k-zsh-theme/.p10k.zsh
      '';
    };
  };
}
