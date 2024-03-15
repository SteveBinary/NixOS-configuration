{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        # show currently open buffers, only when more than one exists
        bufferline = "multiple";
        # highlight all lines with a cursor
        cursorline = true;
        # use relative line numbers
        line-number = "relative";
        # show a ruler at column 150
        rulers = [150];
        # color the mode indicator
        color-modes = true;
        # disable mouse support
        mouse = false;
      };

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      editor.lsp = {
        display-messages = true;
      };

      editor.statusline = {
        mode.insert = "INSERT";
        mode.normal = "NORMAL";
        mode.select = "SELECT";
        left = ["mode" "spinner"];
        center = ["version-control" "file-name"];
        right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
      };
    };
  };
}
