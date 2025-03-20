{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.programs.development.editors.zed;
in
{
  options.my.programs.development.editors.zed = {
    enable = lib.mkEnableOption "Enable Zed";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bash-language-server # Bash
      helm-ls # Helm
      jdt-language-server # Java
      kotlin-language-server # Kotlin
      nginx-language-server # nginx
      nixd # Nix
      python313Packages.python-lsp-server # Python
      rust-analyzer # Rust
      shellcheck # shell script analysis
      taplo # TOML
      tinymist # Typst (language server)
      typescript-language-server # JavaScript, TypeScript
      typst # Typst
      yaml-language-server # YAML
    ];

    programs.zed-editor = {
      enable = true;
      extensions = [
        "asciidoc"
        "basher"
        "catppuccin"
        "catppuccin-icons"
        "docker-compose"
        "dockerfile"
        "gleam"
        "groovy"
        "helm"
        "html"
        "java"
        "javascript"
        "json"
        "kotlin"
        "nginx"
        "nix"
        "toml"
        "typst"
      ];
      userSettings = {
        auto_update = false;
        base_keymap = "JetBrains";
        hour_format = "hour24";
        load_direnv = "shell_hook";
        buffer_font_family = "FiraCode Nerd Font";
        terminal.font_family = "MesloLGM Nerd Font";
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        icon_theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
      };
    };
  };
}
