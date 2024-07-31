# NixOS-configuration

Configuration files for my NixOS machines.

## Machine setup - for NixOS

1. Clone this repo into the home directory of a NixOS-system and change into it.
2. Run the following command when initially setting up the system:
   ```shell
   sudo nixos-rebuild switch --flake .#<<machine>>
   ```
3. If there is a `justfile` defined by the machine's user, it will be automatically created in the `NixOS-configuration` directory.
   It leverages [`just`](https://just.systems/man/en/) to define simple commands for doing NixOS housekeeping,
   like switching configurations and updating the system.

## Home Manager setup - for non-NixOS

1. Clone this repo into the home directory of a NixOS-system and change into it.
2. Run the following command when initially setting up Home Manager:
   ```shell
   nix run nixpkgs#home-manager -- switch --flake .#<<user profile>>-<<user name>>
   ```
3. If there is a `justfile` defined by the user, it will be automatically created in the `NixOS-configuration` directory.
   It leverages [`just`](https://just.systems/man/en/) to define simple commands for doing Home Manager housekeeping,
   like switching configurations and updating the setup.

## Project structure

### lib

Utilities and helper functions.

### machines

Configurations and hardware configurations specific to the respective machine.

### programs

Mostly Home Manger modules for applications as a simple unit that can be imported into other modules.

### users/`<<profile>>`

Home Manager modules for a specific user.
That's the place where to use the previously defined Home Manager modules of the applications.
A `<<profile>>` is just a way to distinguish between users with the same name but different purposes;
like one for your personal system and one for your work computer.
