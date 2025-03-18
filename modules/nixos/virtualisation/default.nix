{
  pkgs,
  lib,
  config,
  vars,
  ...
}:

let
  cfg = config.my.virtualisation;
in
{
  options.my.virtualisation = {
    enableDocker = lib.mkEnableOption "Enable my configuration for Docker virtualisation";
    enablePodman = lib.mkEnableOption "Enable my configuration for Podman virtualisation";
    enableLibvirtd = lib.mkEnableOption "Enable my configuration for libvirtd virtualisation";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableDocker {
      virtualisation = {
        containers.enable = true;
        docker = {
          enable = true;
          storageDriver = "overlay2";
        };
      };

      users.users."${vars.user.name}".extraGroups = [ "docker" ];
    })

    (lib.mkIf cfg.enablePodman {
      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      environment.systemPackages = with pkgs; [
        podman-compose
      ];
    })

    (lib.mkIf cfg.enableLibvirtd {
      programs.virt-manager.enable = true;
      virtualisation.libvirtd.enable = true;
      users.users."${vars.user.name}".extraGroups = [ "libvirtd" ];
    })
  ];
}
