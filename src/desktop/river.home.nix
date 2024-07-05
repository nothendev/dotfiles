{ pkgs, osConfig, ... }:
{
  xdg.configFile."river/init" = {
    enable = false;
    executable = true;
    text = with osConfig.pretty.base69; ''
      #!/usr/bin/env bash

      riverctl map normal Alt+Shift Return spawn alacritty
      riverctl map normal Alt Return toggle-focused-tags $((1 << 9))
      riverctl map normal Alt+Shift Q close

      riverctl map normal Alt+Shift E exit
      riverctl map normal Alt D spawn "rofi -show drun"

      for i in $(seq 1 9)
      do
        tags=$((1 << ($i -1)))
        riverctl map normal Alt $i set-focused-tags $tags
        riverctl map normal Alt+Shift $i set-view-tags $tags
        riverctl map normal Alt+Control $i toggle-focused-tags $tags
      done

      riverctl map normal Alt+Shift Space toggle-float
      riverctl map normal Alt+Shift F toggle-fullscreen

      riverctl map normal Alt Up send-layout-cmd rivertile "main-location top"
      riverctl map normal Alt Right send-layout-cmd rivertile "main-location right"
      riverctl map normal Alt Left send-layout-cmd rivertile "main-location left"
      riverctl map normal Alt Down send-layout-cmd rivertile "main-location bottom"

      # Alt+J and Super+K to focus the next/previous view in the layout stack
      riverctl map normal Alt J focus-view next
      riverctl map normal Alt K focus-view previous

      # Alt+Shift+J and Super+Shift+K to swap the focused view with the next/previous
      # view in the layout stack
      riverctl map normal Alt+Shift J swap next
      riverctl map normal Alt+Shift K swap previous

      # Alt+Period and Super+Comma to focus the next/previous output
      riverctl map normal Alt Period focus-output next
      riverctl map normal Alt Comma focus-output previous

      # Alt+Shift+{Period,Comma} to send the focused view to the next/previous output
      riverctl map normal Alt+Shift Period send-to-output next
      riverctl map normal Alt+Shift Comma send-to-output previous

      # Alt+Return to bump the focused view to the top of the layout stack
      riverctl map normal Alt Return zoom

      # Alt+H and Super+L to decrease/increase the main ratio of rivertile(1)
      riverctl map normal Alt H send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal Alt L send-layout-cmd rivertile "main-ratio +0.05"

      # Alt+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
      riverctl map normal Alt+Shift H send-layout-cmd rivertile "main-count +1"
      riverctl map normal Alt+Shift L send-layout-cmd rivertile "main-count -1"

      # Alt + Left Mouse Button to move views
      riverctl map-pointer normal Alt BTN_LEFT move-view

      # Alt + Right Mouse Button to resize views
      riverctl map-pointer normal Alt BTN_RIGHT resize-view

      # Alt + Middle Mouse Button to toggle float
      riverctl map-pointer normal Alt BTN_MIDDLE toggle-float

      # Set background and border color
      riverctl background-color 0x${surface0}
      riverctl border-color-focused 0x${sapphire}
      riverctl border-color-unfocused 0x${yellow}af

      riverctl default-layout rivertile
      rivertile -view-padding 6 -outer-padding 6 &
      eww open desktop &
      mako &

      riverctl focus-output next
      riverctl set-focused-tags $((1 << 9))
      alacritty &
      riverctl set-focused-tags 0
      riverctl set-view-tags $((1 << 9))
    '';
  };
}
