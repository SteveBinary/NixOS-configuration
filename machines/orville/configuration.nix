{
  pkgs,
  lib,
  vars,
  ...
}:

{
  ########## My NixOS modules #####################################################################

  my = {
    common-utilities.enable = true;
    virtualisation.enableDocker = true;
    nix = {
      enable = true;
      trusted-users = [ vars.user.name ];
    };
  };

  ########## NixOS ################################################################################

  system.stateVersion = "25.05"; # Change with great care!

  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ vars.user.name ];

  ########## boot ################################################################################

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl."vm.swappines" = 10;
    kernelPackages = pkgs.linuxPackages_6_12;
  };

  ########## networking ###########################################################################

  networking = {
    hostName = vars.machine;
    firewall.enable = true;
    defaultGateway = "192.168.100.1";
    nameservers = [ "192.168.100.1" ];
    interfaces.enp5s0.ipv4.addresses = [
      {
        address = "192.168.100.50";
        prefixLength = 24;
      }
    ];
  };

  ########## services #############################################################################

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      banner = lib.concatLines [
        # using https://manytools.org/hacker-tools/ascii-banner/ with font ANSI Shadow and horizontal/vertical spacing of Normal
        " ██████╗ ██████╗ ██╗   ██╗██╗██╗     ██╗     ███████╗"
        "██╔═══██╗██╔══██╗██║   ██║██║██║     ██║     ██╔════╝"
        "██║   ██║██████╔╝██║   ██║██║██║     ██║     █████╗  "
        "██║   ██║██╔══██╗╚██╗ ██╔╝██║██║     ██║     ██╔══╝  "
        "╚██████╔╝██║  ██║ ╚████╔╝ ██║███████╗███████╗███████╗"
        " ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝╚══════╝╚══════╝"
      ];
    };
    iperf3 = {
      enable = true;
      openFirewall = true;
    };
  };

  ########## localizaiton #########################################################################

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";

  ########## users ################################################################################

  users.users."${vars.user.name}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$evTl0fYErvBLX35Ooealp1$tb5NthTn1CCVDd4E/ChUPruF3ADGj4XBpVd/suuvBb3";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhJ8AAl4pGSIH3m4+ok3cwKHJqvI6Chi4QJprSNvBw8 orville"
    ];
  };

  ########## environment  #########################################################################

  virtualisation.incus.agent.enable = true;

  environment.systemPackages = with pkgs; [
    gitMinimal
  ];
}
