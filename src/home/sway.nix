{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      outputs = {
        DVI-D-1 = {
          bg = ../assets/wallpapers/sky-vaporwave-thing-sun.jpg;
        };
        HDMI-A-1 = {
          bg = ../assets/wallpapers/hyprland1-dark.png;
        };
      };
      floating.modifier = modifier;
      focus = {
        followMouse = "yes";
        mouseWarping = true;
      };
      fonts = {
        names = [ "JetBrainsMono Nerd Font Mono" ];
        size = 11.0;
      };
      bindkeysToCode = true;
      keybindings = {
        "${modifier}+Return" = "scratchpad show";
        "${modifier}+Shift+Return" = "exec kitty";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Print" = "";
      };
      menu = "rofi -drun";
      startup = [
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
      ];
    };
  };
}
