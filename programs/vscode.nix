{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
    ];
    userSettings = {
      editor.fontFamily = "Fira Code";
      editor.fontLigatures = true;
      terminal.integrated.fontFamily = "Fira Code";
      update.mode = "none";
      workbench.startupEditor = "none";
    };
  };
}
