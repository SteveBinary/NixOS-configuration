# NixOS-configuration

Configuration files for my NixOS machines.

## Machine setup

1. Clone this repo into the home directory of a NixOS-system.
2. Create a symlink so that the config is visible in the expected location:
   ```shell
   sudo ln -s $HOME/NixOS-configuration /etc/nixos
   ```
3. Setting up a machine for the first time, running the following command to activate the correct configuration is necessary.
   Later, the shell alias `config-switch` was generated with the `<MACHINE>` backed in.
   ```shell
   sudo nixos-rebuild switch --flake ~/NixOS-configuration#<MACHINE>
   ```
4. After setting up the machine with the previous command, there is a shell alias called `update-packages`.
   It updates the flake inputs and saves the new versions in the `flake.lock` to make all software versions used in the system truly reproducible.
   It automatically calls `config-switch` to build and apply the updates immediately.

## Project structure

### lib

Utilities and helper functions.

### machines

Configurations and hardware configurations specific to the respective machine.

### programs

Mostly Home Manger modules for applications as a simple unit that can be imported into other modules.

### users

Home Manager modules for a specific user.
That's the place where to use the previously defined Home Manager modules of the applications.
