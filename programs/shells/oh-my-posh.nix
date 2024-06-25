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
      palette = {
        os = "#ACB0BE";
        closer = "p:os";
        pink = "#F5C2E7";
        lavender = "#B4BEFE";
        blue = "#89B4FA";
      };
      secondary_prompt = {
        template = " ";
        foreground = "p:closer";
      };
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "os";
              template = "{{.Icon}} ";
              style = "plain";
              foreground = "p:os";
            }
            {
              type = "session";
              template = "{{ .UserName }}@{{ .HostName }} ";
              style = "plain";
              foreground = "p:blue";
            }
            {
              type = "path";
              template = "{{ .Path }}";
              style = "plain";
              foreground = "p:pink";
              properties = {
                folder_icon = ".. ..";
                home_icon = "~";
                style = "agnoster_short";
              };
            }
            {
              type = "git";
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
