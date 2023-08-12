{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernel.sysctl = { "vm.swappines" = 10; };
  };

  virtualisation.vmware.guest.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "dev-vm";
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "de";
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
    printing = {
      enable = true;
    };
  };

  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  environment.shells = [ pkgs.zsh ];
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users = {
    steve = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$6$io3VnfXOA1CbMQoC$y9rrtSgnqxQM/0YMjk5ew7IxTj/Ewl6yZXXzliVLXmpmp77JNpCbmlQRpEGeV.jhbb9IxiSTpJ5.cZPUf/GyI0"; # generated with 'mkpassed -m sha-512'
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    curl
    hdparm
    lshw
    lsscsi
    pciutils
    trash-cli
    usbutils
    wget
  ];

  fonts.packages = with pkgs; [
    ( nerdfonts.override { fonts = [ "FiraCode" ]; } )
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "flakes" "nix-command" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  system = {
    autoUpgrade.enable = true;
    stateVersion = "23.05";
  };
}
