{
  config,
  pkgs,
  osConfig,
  ## Catppuccin
  catppuccin-alacritty,
  catppuccin-starship,
  ...
}:
{
  programs.starship =
    let
      flavour = "mocha";
      base69 = osConfig.pretty.base69;
    in
    {
      enable = false;
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
      } // builtins.fromTOML (builtins.readFile (catppuccin-starship + /themes/${flavour}.toml));
    };

  programs.alacritty.settings = {
    general.import = [ (catppuccin-alacritty + /catppuccin-mocha.toml) ];
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
    enable = false;
    iconTheme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-icon-theme.override { themeVariants = [ "purple" ]; };
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = null;
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "Adwaita-Dark";
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
