{ user, ... }:

{
  # actually enabling virt-manager and virtualisation.libvirtd is done in the machine's configuration
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
