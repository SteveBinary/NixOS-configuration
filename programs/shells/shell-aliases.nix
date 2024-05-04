{ machine }:

{
  c = "clear";
  cat = "bat";

  gaa = "git add --all";
  gc = "git commit";
  gl = "git log";
  gp = "git pull";
  gpush = "git push";
  gs = "git status";

  l = "lsd --long --group-directories-first";
  ls = "lsd --long --group-directories-first";
  la = "lsd --all --long --group-directories-first";
  ll = "lsd --all --long --group-directories-first";

  n = "cd ~/NixOS-configuration";

  p = "cd ~/Projects";

  reboot-now = "sudo reboot now";
  rm = "echo 'Use trash-put <file/directory> for using the trash. Use \\\\rm <file/directory> if you are sure.'; false";

  sudo = "sudo "; # for shell aliases to be usable wiith sudo

  ### NixOS related ###

  config-switch = "sudo nixos-rebuild switch --flake ~/NixOS-configuration#${machine}";
  config-switch-verbose = "config-switch --verbose --show-trace";

  update-packages = ''echo 'Updating flake...' && sudo nix flake update ~/NixOS-configuration && echo 'Rebuild and switch...' && config-switch'';
  update-packages-verbose = ''echo 'Updating flake...' && sudo nix flake update --debug ~/NixOS-configuration && echo 'Rebuild and switch...' && config-switch-verbose'';

  collect-garbage = "sudo nix-collect-garbage"; # run 'collect-garbage -d' to delete all generations except the current one

  list-generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
}
