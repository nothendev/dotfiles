{ pkgs, osConfig, ... }:
let
  lib = pkgs.lib;
  dsl = import ../common/hyprdsl.nix {
    inherit (pkgs) lib;
  };
  base69 = osConfig.pretty.base69;
in
{
  imports = [ ./hyprlandy.nix ];
  wayland.windowManager.hyprlandy = {
    enable = true;
    systemdIntegration = true;
    finalPackage = osConfig.programs.hyprland.finalPackage;
    settings =
      with dsl // dsl.fn;
      let
        makeKitty = "[workspace special:kitty silent; float; noanim; move 12 68; size 1896 1000] kitty";
        mod = "SUPER";
        bindms = bind [ mod "SHIFT" ];
        bindmov = n: bind mod (toString n) (workspace n);
        bindsmov = n: bindms (toString n) (movetoworkspace n);
        workspacen = lib.lists.range 1 9;
      in
      {
        monitor = ",preferred,auto,auto";

        exec = [
          "hyprpaper"
        ];

        exec-once = [
          "~/.config/eww/scripts/init"
          "mako"
          makeKitty
          "playerctld"
          "[workspace 2] librewolf"
        ];

        bind = [
          (bind null "XF86AudioPlay" (exec "playerctl play-pause"))

          # Win-Shift-Enter: launch a new kitty
          (bindms "RETURN" (exec "kitty"))

          (bind mod "RETURN" (togglespecialworkspace' "kitty"))
          (bindms "Q" killactive)
          (bindms "SPACE" togglefloating)
          (bind mod "D" (exec "rofi -show drun"))
          (bind mod "P" pseudo)
          (bind mod "J" togglesplit)
          (bind mod "S" togglegroup)
          (bind mod "TAB" (changegroupactive dir.forward))
          (bindms "TAB" (changegroupactive dir.back))
          (bind null "Print" (exec "grim -g \"$(slurp)\""))
          (bind "CTRL" "code:49" (exec "hyprctl switchxkblayout microsoft-wired-keyboard-600 next"))
          (bindms "F" fullscreen)
          (bindms "G" moveoutofgroup)
          (bindms "H" (moveintogroup dir.left))
          (bindms "J" (moveintogroup dir.down))
          (bindms "K" (moveintogroup dir.up))
          (bindms "L" (moveintogroup dir.right))
          (bindms "left" (movewindow dir.left))
          (bindms "right" (movewindow dir.right))
          (bindms "up" (movewindow dir.up))
          (bindms "down" (movewindow dir.down))
          (bindms "A" (exec "~/.config/eww/scripts/init"))
          (bindms "S" (exec makeKitty))
          (bind mod "left" (movefocus dir.left))
          (bind mod "right" (movefocus dir.right))
          (bind mod "up" (movefocus dir.up))
          (bind mod "down" (movefocus dir.down))
          (bind mod "mouse_down" (workspace (workspace'.relative-open 1)))
          (bind mod "mouse_up" (workspace (workspace'.relative-open (- 1))))
        ] ++ map bindmov workspacen ++ map bindsmov workspacen;

        bindm = [
          (bind mod "mouse:272" movewindow')
          (bind mod "mouse:273" resizewindow')
        ];

        env = [
          (env "XCURSOR_SIZE" 24)
          (env "WLR_NO_HARDWARE_CURSORS" 1)
          (env "MOZ_ENABLE_WAYLAND" 1)
          (env "NIXOS_OZONE_WL" 1)
        ];

        input = {
          kb_layout = "us,ru";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0;
        };

        general = with base69; {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "0xff${sapphire.hex} 0xff${blue.hex} 45deg";
          "col.inactive_border" = "0xaf${yellow.hex}";
          "col.group_border" = "0xaf${yellow.hex}";
          "col.group_border_active" = "0xff${blue.hex} 0xff${lavender.hex} 45deg";
          cursor_inactive_timeout = 30;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "0xff${base69.surface0.hex}";

          blur.enabled = true;
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin ${perc 80}"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master.new_is_master = true;
        gestures.workspace_swipe = false;

        misc = {
          disable_autoreload = true;
          groupbar_gradients = false;
          group_insert_after_current = false;
        };
      };
  };
  services.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono";
    backgroundColor = "#${base69.base.hex}ff";
  };
}
