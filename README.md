# NixOS-configuration

Configuration files for my NixOS machines.

## Machine setup

1. Clone this repo into the home directory of a NixOS-system.
2. Setting up a machine for the first time, running the following command to activate the correct configuration is necessary.
   ```shell
   just config-switch <<machine>>
   ```
   You might have to enter a nix-shell with the `just` package to execute this command.
3. After setting up the machine with the previous command, you can execute `just update-system`.
   It updates the flake inputs and saves the new versions in the `flake.lock` to make all software versions used in the system truly reproducible.
   It automatically builds and applies the updates immediately.

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
