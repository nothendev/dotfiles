{ pkgs, osConfig, ... }:
{
  xdg.configFile."river/init" = {
    executable = true;
    text = with osConfig.pretty.base69; ''
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

      # Super+J and Super+K to focus the next/previous view in the layout stack
      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
      # view in the layout stack
      riverctl map normal Super+Shift J swap next
      riverctl map normal Super+Shift K swap previous

      # Super+Period and Super+Comma to focus the next/previous output
      riverctl map normal Super Period focus-output next
      riverctl map normal Super Comma focus-output previous

      # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
      riverctl map normal Super+Shift Period send-to-output next
      riverctl map normal Super+Shift Comma send-to-output previous

      # Super+Return to bump the focused view to the top of the layout stack
      riverctl map normal Super Return zoom

      # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
      riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

      # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
      riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
      riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

      # Super + Left Mouse Button to move views
      riverctl map-pointer normal Super BTN_LEFT move-view

      # Super + Right Mouse Button to resize views
      riverctl map-pointer normal Super BTN_RIGHT resize-view

      # Super + Middle Mouse Button to toggle float
      riverctl map-pointer normal Super BTN_MIDDLE toggle-float

      # Set background and border color
      riverctl background-color 0x${surface0}
      riverctl border-color-focused 0x${sapphire}
      riverctl border-color-unfocused 0x${yellow}af

      riverctl default-layout rivertile
      rivertile -view-padding 6 -outer-padding 6 &
      eww open desktop &
      mako &
    '';
  };
}
