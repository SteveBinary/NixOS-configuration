# NixOS-configuration

Configuration files for NixOS used in a VMware-VM for development.

## How to edit without `sudo`

1. Clone this repo into your home directory.
2. Create a symlink so that the config is visible in the expected location:
   ```shell
   sudo ln -s $HOME/NixOS-configuration /etc/nixos
   ```
