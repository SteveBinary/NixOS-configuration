{
  c = "clear";
  cat = "bat";

  gs = "git status";

  k = "kubecolor";
  kx = "kubectx";
  kn = "kubens";
  kd = "k describe";
  kg = "k get";
  kga = "k get all";
  kgp = "k get pods";
  kgs = "k get services";
  kgn = "k get networkpolicies";
  kds = ''sh -c 'kubectl get secret "$@" -o json | jq ".data | map_values(@base64d)"' _'';

  l = "lsd --long --group-directories-first";
  ls = "lsd --long --group-directories-first";
  la = "lsd --all --long --group-directories-first";
  ll = "lsd --all --long --group-directories-first";

  n = "cd ~/NixOS-configuration";

  p = "cd ~/Projects";

  reboot-now = "sudo shutdown -r now";

  sudo = "sudo "; # for shell aliases to be usable with sudo
}
