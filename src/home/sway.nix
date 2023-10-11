{ config, lib, pkgs, osConfig, ... }:

let base69 = osConfig.pretty.base69;
in {
  home.packages = with pkgs; [ flameshot ];
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      bars = [ ];
      colors = let
        default = {
          border = base69.crust;
          background = base69.base;
          text = base69.text;
          indicator = base69.peach;
          childBorder = base69.mantle;
        };
      in {
        background = base69.base;
        focused = default // { background = base69.surface1; };
        focusedInactive = default // { border = base69.overlay1; };
        unfocused = default;
        urgent = default // { background = base69.red; };
      };
      output = {
        DVI-D-1 = {
          bg = "${../assets/wallpapers/sky-vaporwave-thing-sun.jpg} fill";
        };
        HDMI-A-1 = { bg = "${../assets/wallpapers/hyprland1-dark.png} fill"; };
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
      keybindings = let workspacen = lib.lists.range 1 9;
      in {
        "${modifier}+Return" = "scratchpad show";
        "${modifier}+Shift+Return" = "exec kitty";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Print" = "exec flameshot gui";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Alt+q" = "kill -9";
        "${modifier}+a" = "layout tabbed";
        "${modifier}+s" = "layout stacking";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+h" = "focus left";
        "${modifier}+Left" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+Down" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+Up" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+right" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+right" = "move right";
      } // lib.attrsets.mergeAttrsList (map (n: {
        "${modifier}+${toString n}" = "workspace number ${toString n}";
        "${modifier}+Shift+${toString n}" =
          "move container to workspace number ${toString n}";
      }) workspacen);
      keycodebindings = {
        "control+49" = ''
          exec swaymsg "input type:keyboard xkb_switch_layout $(swaymsg -t get_inputs | jq 'if .[0].xkb_active_layout_index == 0 then 1 else 0 end')"'';
      };
      menu = "rofi -show drun";
      startup = [
        { command = "dbus-sway-environment"; }
        { command = "configure-gtk"; }
        {
          command = "~/.config/eww/scripts/init";
          always = true;
        }
      ];
      gaps.smartBorders = "on";
      window.hideEdgeBorders = "both";
      window.border = 1;
      input = { "*" = { xkb_layout = "us,ru"; }; "type:keyboard" = { xkb_numlock = "enabled"; }; };
    };
  };
}
