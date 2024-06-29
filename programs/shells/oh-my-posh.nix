{ pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      version = 2;
      auto_upgrade = false;
      disable_notice = true;
      final_space = true;
      terminal_background = "#1E1E2E";
      palette = {
        os = "#ACB0BE";
        closer = "p:os";
        pink = "#F5C2E7";
        lavender = "#B4BEFE";
        blue = "#89B4FA";
        error = "#D0164A";
      };
      secondary_prompt = {
        template = " ";
        foreground = "p:closer";
      };
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "os";
              template = "{{ if .WSL }}WSL at {{ end }}{{ .Icon }}";
              style = "plain";
              foreground = "p:os";
            }
            {
              type = "session";
              style = "plain";
              foreground = "p:blue";
            }
            {
              type = "path";
              template = "{{ if not .Writable }}<p:error> </>{{ end }}{{ .Path }} ";
              style = "plain";
              foreground = "p:pink";
              properties = {
                style = "full";
                home_icon = "~";
              };
            }
            {
              type = "kubectl";
              template = "󱃾 {{ .Context }}{{ if .Namespace }}::{{ .Namespace }}{{ end }} ";
              style = "plain";
              foreground = "p:blue";
              propterties = {
                parse_kubeconfig = true;
              };
            }
            {
              type = "git";
              template = "{{ .UpstreamIcon }}{{ .HEAD }}{{ if .BranchStatus }} {{ .BranchStatus }}{{ end }}" +
                         "{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}" +
                         "{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }}";
              style = "plain";
              foreground = "p:lavender";
              properties = {
                branch_icon = " ";
                cherry_pick_icon = " ";
                commit_icon = " ";
                fetch_status = true;
                fetch_upstream_icon = true;
                merge_icon = " ";
                no_commits_icon = " ";
                rebase_icon = " ";
                revert_icon = " ";
                tag_icon = " ";
              };
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "root";
              style = "plain";
              foreground = "p:error";
            }
            {
              type = "text";
              template = "";
              style = "plain";
              foreground = "p:closer";
            }
          ];
        }
      ];
    };
  };
}
