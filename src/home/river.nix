{ pkgs, ... }: {
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      riverctl map normal Super+Shift Return spawn kitty
      riverctl map normal Super+Shift Q close

      riverctl map normal Super+Shift E exit
      riverctl map normal Super D spawn "rofi -show drun"

      for i in $(seq 1 9)
      do
        tags=$((1 << ($i -1)))
        riverctl map normal Super $i set-focused-tags $tags
        riverctl map normal Super+Shift $i set-view-tags $tags
        riverctl map normal Super+Control $i toggle-focused-tags $tags
      done

      riverctl map normal Super+Shift Space toggle-float
      riverctl map normal Super+Shift F toggle-fullscreen

      riverctl map normal Super Up send-layout-cmd rivertile "main-location top"
      riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
      riverctl map normal Super Left send-layout-cmd rivertile "main-location left"
      riverctl map normal Super Down send-layout-cmd rivertile "main-location bottom"

      riverctl default-layout rivertile
      rivertile -view-padding 6 -outer-padding 6 &
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
