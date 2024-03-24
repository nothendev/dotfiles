{ config, pkgs, osConfig,
## Catppuccin
catppuccin-alacritty, catppuccin-starship, ... }: {
  programs.starship = let
    flavour = "mocha";
    base69 = osConfig.pretty.base69;
  in {
    enable = true;
    settings = {
      palette = "catppuccin_${flavour}";
      format = ''
        $directory[\[$rust\]](fg:#${base69.mauve})
        $status '';
      status = {
        disabled = false;
        success_symbol = "[>](fg:#${base69.green})";
        symbol = "[$status>](fg:#${base69.red})";
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
    } // builtins.fromTOML
      (builtins.readFile (catppuccin-starship + /palettes/${flavour}.toml));
  };

  programs.alacritty.settings = {
    import = [ (catppuccin-alacritty + /catppuccin-mocha.toml) ];
    window.opacity = 0.5;
    font.normal = {
      family = osConfig.pretty.font.family;
      style = "Regular";
    };
    font.size = 12.25;
    cursor.style.shape = "Beam";
    cursor.vi_mode_style.shape = "Block";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-Dark";
      package =
        pkgs.whitesur-icon-theme.override { themeVariants = [ "purple" ]; };
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
      name = osConfig.pretty.font.family;
      package = null;
      size = 11;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    location = "top";
    terminal = "${config.programs.alacritty.package}/bin/alacritty";
    font = osConfig.pretty.font.family;
  };

  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ../configs/eww;
  };
}
