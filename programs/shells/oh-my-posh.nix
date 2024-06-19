{ pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      version = 2;
      final_space = true;
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "os";
              style = "diamond";
              background = "#ffffff";
              foreground = "#000000";
              leading_diamond = "";
              template = "{{ if .WSL }}WSL at {{ end }}{{.Icon}} ";
            }
            {
              background = "#40189c";
              foreground = "#ffffff";
              style = "diamond";
              template = "❘|｜ {{ .UserName }}@{{ .HostName }} ";
              type = "session";
            }
            {
              background = "#0000ff";
              foreground = "#000000";
              powerline_symbol = "";
              properties.style = "full";
              style = "powerline";
              template = "  ";
              type = "root";
            }
            {
              background = "#0000ff";
              foreground = "#ffffff";
              powerline_symbol = "";
              properties = {
                style = "full";
              };
              style = "powerline";
              template = " {{ .Path }} ";
              type = "path";
            }
          ];
        }
      ];
    };
  };
}
