{ pkgs, pkgs-stable, hostName, ... }:

{
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

  virtualisation.vmware.guest.enable = true; # This system runs inside a VMware VM

  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };

  networking = {
    networkmanager.enable = true;
    inherit hostName;
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
      xkb.layout = "de";
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "steve";
      };
    };
    printing.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default, no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.shells = [ pkgs.zsh ];
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  hardware.opengl.enable = true;

  users.users = {
    steve = {
      description = "Steve";
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

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

  fonts.packages = with pkgs; [
    ( nerdfonts.override { fonts = [ "FiraCode" ]; } )
  ];

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
}
