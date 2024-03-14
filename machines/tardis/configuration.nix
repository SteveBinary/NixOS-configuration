{ pkgs, pkgs-stable, lib, machine, user, ... }:

{
  ########## NixOS ################################################################################

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05"; # Change with great care!

  ########## boot #################################################################################

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
    kernel.sysctl."vm.swappines" = 10;
    kernelPackages = pkgs.linuxPackages_6_6;
  };

  virtualisation.vmware.guest.enable = true; # this machine is a VMware VM

  ########## networking ###########################################################################

  networking = {
    networkmanager.enable = true;
    hostName = machine;
    nftables.enable = true;
    firewall.enable = true;
  };

  ########## services #############################################################################

  services = {
    printing.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "de";
      displayManager = {
        sddm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = user;
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # used by pulseaudio

  ########## localizaiton #########################################################################

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

  ########## users ################################################################################

  users.users = {
    ${user} = {
      description = (import ../../lib/stringUtils.nix lib).upperCaseFirstLetter user;
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  ########## fonts ################################################################################

  fonts.packages = with pkgs; [
    ( nerdfonts.override { fonts = [ "FiraCode" ]; } )
  ];

  ########## environment ##########################################################################

  environment.shells = [ pkgs.zsh ];
  environment.pathsToLink = [ "/share/zsh" ];
  # needed to set zsh in environment.shells although it might also be enabled in a home-manager module
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    bat
    curl
    hdparm
    killall
    lshw
    lsscsi
    pciutils
    trash-cli
    usbutils
    wget
    xclip
  ];
}
