{
  pkgs,
  config,
  osConfig,
  ...
}:
let
  lib = pkgs.lib;
  dsl = import ../common/hyprdsl.nix { inherit (pkgs) lib; };
  base69 = osConfig.pretty.base69;
  fpp = osConfig.programs.hyprland.portalPackage.override { hyprland = osConfig.programs.hyprland.package; };
in
{
  #imports = [ ../home/hyprland.nix ];
  systemd.user.startServices = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = osConfig.programs.hyprland.package;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings =
      with dsl // dsl.fn;
      let
        makeTerminal = "[workspace special:term silent; noanim] ghostty";
        mod = "SUPER";
        bindms = bind [
          mod
          "SHIFT"
        ];
        bindmov = n: bind mod (toString n) (workspace n);
        bindsmov = n: bindms (toString n) (movetoworkspace n);
        workspacen = lib.lists.range 1 9;
      in
      {
        monitor = [
          "Unknown-1, disable"
          "DVI-D-1,1920x1080@60,auto,auto, bitdepth, 8"
          "HDMI-A-1,1920x1080@60,auto,auto, bitdepth, 8"
        ];
        cursor = {
          no_hardware_cursors = true;
        };

        exec = [ "hyprpaper" ];

        exec-once = [
          "~/.config/eww/scripts/init"
          "mako"
          makeTerminal
          "${pkgs.playerctl}/bin/playerctld"
          "[workspace 2] env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland brave --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing"
        ];

        bind =
          [
            (bind null "XF86AudioPlay" (exec "${pkgs.playerctl}/bin/playerctl play-pause"))

            # Win-Shift-Enter: launch a new term instance
            (bindms "RETURN" (exec "alacritty"))

            (bind mod "RETURN" (togglespecialworkspace' "term"))
            (bindms "Q" killactive)
            #(bind [ mod "CTRL" "SHIFT" ] "Q" forcekillactive)
            (bindms "SPACE" togglefloating)
            (bind mod "D" (exec "rofi -show drun"))
            (bind mod "J" togglesplit)
            (bind mod "S" togglegroup)
            (bind mod "TAB" (changegroupactive dir.forward))
            (bindms "TAB" (changegroupactive dir.back))
            (bind null "Print" (exec ''grim -g "$(slurp)"''))
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
            (bindms "S" (exec makeTerminal))
            (bind mod "left" (movefocus dir.left))
            (bind mod "right" (movefocus dir.right))
            (bind mod "up" (movefocus dir.up))
            (bind mod "down" (movefocus dir.down))
            (bind mod "H" (movefocus dir.left))
            (bind mod "J" (movefocus dir.down))
            (bind mod "K" (movefocus dir.up))
            (bind mod "L" (movefocus dir.right))
            (bind mod "mouse_down" (workspace (workspace'.relative-open 1)))
            (bind mod "mouse_up" (workspace (workspace'.relative-open (-1))))
            (bind mod "P" (exec "wpctl set-mute 61 toggle"))
          ]
          ++ map bindmov workspacen
          ++ map bindsmov workspacen;

        bindm = [
          (bind mod "mouse:272" movewindow')
          (bind mod "mouse:273" resizewindow')
        ];

        env = [
          (env "XCURSOR_SIZE" 24)
          (env "WLR_NO_HARDWARE_CURSORS" 1)
          (env "MOZ_ENABLE_WAYLAND" 1)
          (env "NIXOS_OZONE_WL" 1)
          (env "LIBVA_DRIVER_NAME" "nvidia")
          (env "XDG_SESSION_TYPE" "wayland")
          (env "GBM_BACKEND" "nvidia-drm")
          (env "__GLX_VENDOR_LIBRARY_NAME" "nvidia")
        ];

        input = {
          kb_layout = "us,ru";
          kb_options = "ctrl:nocaps";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0;
        };

        general = with base69; {
          gaps_in = 0;
          gaps_out = 1;
          border_size = 1;
          "col.active_border" = "0xff${sapphire} 0xff${blue} 45deg";
          "col.inactive_border" = "0xaf${yellow}";
          layout = "dwindle";
        };

        group = with base69; {
          insert_after_current = false;
          "col.border_inactive" = "0xaf${yellow}";
          "col.border_active" = "0xff${blue} 0xff${lavender} 45deg";

          groupbar = {
            gradients = false;
            render_titles = false;
          };
        };

        decoration = {
          rounding = 0;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "0xff${base69.surface0}";

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

        #master.new_is_master = true;
        gestures.workspace_swipe = false;

        misc = {
          disable_autoreload = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = osConfig.pretty.font.family;
        };
      };
  };

  xdg.portal = {
    enable = true;
    config.common = {
      default = "*";
    };
    config.hyprland = {
      default = "*";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      fpp
    ];
    xdgOpenUsePortal = false;
    configPackages = [ osConfig.programs.hyprland.package ];
  };
  
  home.sessionVariables = {
    NIX_XDG_DESKTOP_PORTAL_DIR = pkgs.lib.mkForce "/run/current-system/sw/share/xdg-desktop-portal/portals";
  };

  systemd.user.sessionVariables = {
    NIX_XDG_DESKTOP_PORTAL_DIR = pkgs.lib.mkForce "/run/current-system/sw/share/xdg-desktop-portal/portals";
  };

  services.mako = {
    enable = true;
    font = osConfig.pretty.font.family;
    backgroundColor = "#${base69.base}ff";
    borderColor = "#${base69.mantle}ff";
    textColor = "#${base69.text}ff";
  };
}
