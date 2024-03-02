{ config, pkgs, osConfig, ... }:
{
  programs.starship =
    let
      flavour = "mocha";
      base69 = osConfig.pretty.base69;
    in
    {
      enable = true;
      settings = {
        palette = "catppuccin_${flavour}";
        format = ''$directory[\[$rust\]](fg:#${base69.mauve})
$status '';
        status = {
          disabled = false;
          success_symbol = "[>](fg:#${base69.green})";
          symbol = "[>](fg:#${base69.red})";
          not_executable_symbol = "[-x>](fg:#${base69.maroon})";
          format = "$symbol";
        };
        directory = {
          disabled = false;
          truncate_to_repo = false;
          read_only = "(ro) ";
          format = "[$read_only]($read_only_style)[$path]($style)";
          read_only_style = "italic fg:#${base69.peach}";
          style = "fg:#${base69.teal}";
        };
        rust = {
          disabled = false;
          format = "[$version]($style)";
          style = "fg:#${base69.red}";
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

  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "alacritty";
          rev = "832787d6cc0796c9f0c2b03926f4a83ce4d4519b";
          sha256 = "sha256-irU6ThA4uvHW146UOqlOHeDbvQyFX3f9R8f16MBEFxM=";
        } + /catppuccin-mocha.toml)
      ];
      window.opacity = 0.5;
      font.normal = {
        family = "Miracode Nerd Font";
        style = "Regular";
      };
      font.size = 12.25;
    };
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
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
    };
    font = {
      name = "Miracode";
      package = null;
      size = 10;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    location = "top";
    terminal = "${config.programs.alacritty.package}/bin/alacritty";
    font = config.programs.alacritty.settings.font.normal.family;
  };

  programs.eww = {
    enable = true;
    package = with pkgs;
      (eww-wayland.override { withWayland = true; });
    configDir = ../configs/eww;
  };
}
