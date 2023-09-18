{ config, pkgs, osConfig, ... }:
{
  programs.starship =
    let
      flavour = osConfig.pretty.catppuccin.flavour;
      base69 = osConfig.pretty.base69;
    in
    {
      enable = true;
      settings = {
        palette = "catppuccin_${flavour}";
        format = ''$rust
$directory$status '';
        status = {
          disabled = false;
          success_symbol = "[>](fg:#${base69.green.hex})";
          symbol = "[>](fg:#${base69.red.hex})";
          not_executable_symbol = "[ -x>](fg:#${base69.maroon.hex})";
          format = "$symbol";
        };
        directory = {
          disabled = false;
          truncate_to_repo = false;
          read_only = "(ro) ";
          format = "[$read_only]($read_only_style)[$path]($style)";
          read_only_style = "italic fg:#${base69.peach.hex}";
          style = "fg:#${base69.teal.hex}";
        };
        rust = {
          disabled = false;
          format = "[rs\\($version\\)]($style)";
          style = "fg:#${base69.red.hex}";
        };
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
    };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      name = "JetBrainsMono Nerd Font Mono Regular";
      size = 14;
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      include ~/.config/kitty/current-theme.conf
      background_opacity 0.5
      background_blur 1
      disable_ligatures never
      tab_bar_min_tabs            1
      tab_bar_edge                bottom
      tab_bar_style               powerline
      tab_powerline_style         slanted
      tab_title_template          {title}{\' :{}:\'.format(num_windows) if num_windows > 1 else \'\'}
    '';
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-icon-theme.override { themeVariants = [ "purple" ]; };
    };
    theme = {
      name = "Catppuccin-Mocha-Compact-Sapphire-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = null;
      size = 10;
    };
  };
}
