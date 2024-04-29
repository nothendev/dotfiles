{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

let
  base69 = osConfig.pretty.base69;
in
{
  home.packages = with pkgs; [ flameshot ];
  xsession.windowManager.i3 =
    let
      kitty = ''"kitty && swaymsg 'floating enable, border none, resize set 1920 1065, move scratchpad'"'';
    in
    {
      enable = true;
      config = rec {
        modifier = "Mod4";
        bars = [ ];
        colors =
          let
            default = {
              border = base69.crust;
              background = base69.base;
              text = base69.text;
              indicator = base69.peach;
              childBorder = base69.mantle;
            };
          in
          {
            background = base69.base;
            focused = default // {
              background = base69.surface1;
            };
            focusedInactive = default // {
              border = base69.overlay1;
            };
            unfocused = default;
            urgent = default // {
              background = base69.red;
            };
          };
        # output = {
        #   DVI-D-1 = {
        #     bg = "${../assets/wallpapers/sky-vaporwave-thing-sun.jpg} fill";
        #   };
        #   HDMI-A-1 = { bg = "${../assets/wallpapers/hyprland1-dark.png} fill"; };
        # };
        floating.modifier = modifier;
        focus = {
          followMouse = true;
          mouseWarping = true;
        };
        fonts = {
          names = [ "JetBrainsMono Nerd Font Mono" ];
          size = 11.0;
        };
        # bindkeysToCode = true;
        keybindings =
          let
            workspacen = lib.lists.range 1 9;
          in
          {
            "${modifier}+Return" = "scratchpad show";
            "${modifier}+Shift+Return" = "exec kitty";
            "${modifier}+d" = "exec ${menu}";
            "Print" = "exec flameshot gui";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+Alt+q" = "kill -9";
            "${modifier}+a" = "layout tabbed";
            "${modifier}+s" = "layout stacking";
            "${modifier}+f" = "layout default";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+Semicolon" = "layout splith";
            "${modifier}+Apostrophe" = "layout splitv";
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
            "XF86AudioPlay" = "exec playerctl play-pause";
            "${modifier}+Shift+a" = "exec ${kitty}";
            "${modifier}+Shift+f" = "fullscreen toggle";
          }
          // lib.attrsets.mergeAttrsList (
            map (n: {
              "${modifier}+${toString n}" = "workspace number ${toString n}";
              "${modifier}+Shift+${toString n}" = "move container to workspace number ${toString n}";
            }) workspacen
          );
        keycodebindings = {
          "control+49" = ''exec swaymsg "input type:keyboard xkb_switch_layout $(swaymsg -t get_inputs | jq 'if .[0].xkb_active_layout_index == 0 then 1 else 0 end')"'';
        };
        menu = "rofi -show drun";
        startup = [
          { command = "dbus-sway-environment"; }
          { command = "configure-gtk"; }
          {
            command = "~/.config/eww/scripts/init";
            always = true;
          }
          {
            command = "playerctld daemon";
            always = true;
          }
          { command = "--no-startup-id ${kitty}"; }
        ];
        gaps.smartBorders = "on";
        window.hideEdgeBorders = "both";
        # input = { "*" = { xkb_layout = "us,ru"; }; "type:keyboard" = { xkb_numlock = "enabled"; }; };
      };
      extraConfig = ''
        default_border none
        default_floating_border normal 6
      '';
    };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # MOZ_USE_XINPUT2 = "1";
    # XWAYLAND_NO_GLAMOR = "1";
  };
}
