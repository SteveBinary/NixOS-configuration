{
  pkgs,
  config,
  inputs,
  vars,
  ...
}:

let
  myLib = vars.myLib pkgs;
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  ########## My NixOS modules #####################################################################

  my = {
    common-utilities.enable = true;
    desktop.plasma.enable = true;
    nix.enable = true;
    virtualisation = {
      enableDocker = true;
      enablePodman = true;
      enableLibvirtd = true;
      ociContainersBackend = "docker";
    };
  };

  programs.adb.enable = true;

  hardware.flipperzero.enable = true;
  services.hardware.openrgb.enable = true;

  ########## NixOS ################################################################################

  system.stateVersion = "25.11"; # Change with great care!

  nixpkgs.config.allowUnfree = true;

  ########## boot #################################################################################

  boot = {
    initrd.luks.devices."luks-2634ae65-a0f5-4938-aabe-52d2fc9f40aa".device =
      "/dev/disk/by-uuid/2634ae65-a0f5-4938-aabe-52d2fc9f40aa"; # Swap
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernel.sysctl."vm.swappines" = 10;
    kernelPackages = pkgs.linuxPackages_6_14;
  };

  ########## networking ###########################################################################

  networking = {
    hostName = vars.machine;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53317 # LocalSend
      ];
      allowedTCPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPorts = [
        53317 # LocalSend
      ];
      allowedUDPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
      ];
    };
  };

  ########## services, sound, hardware ############################################################

  services = {
    flatpak.enable = true;
    fwupd.enable = true;
    ollama.enable = true; # hardware acceleration doesn't work properly with the AMD Radeon 780M
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ]; # HP printer
    };
    avahi = {
      # for discovery of network devices like printers
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    xserver = {
      enable = true;
      xkb.layout = "de";
      videoDrivers = [ "amdgpu" ]; # is actually for X11 and Wayland
    };
  };

  security.rtkit.enable = true; # used by PipeWire

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

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
    "${vars.user.name}" = {
      description = myLib.stringUtils.upperCaseFirstLetter vars.user.name;
      isNormalUser = true;
      home = vars.user.home;
      extraGroups = [
        "adbusers" # android debug bridge
        "dialout" # e.g. for espflash
        "networkmanager"
        "wheel"
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  ########## fonts ################################################################################

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];

  ########## environment and programs #############################################################

  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    nix-ld.enable = true; # run dynamically linked executables intended for generic Linux environments
    steam.enable = true;
    zsh.enable = true;
  };
}
