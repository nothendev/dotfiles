{
  config,
  zig,
  pkgs,
  fjo,
  system,
  osConfig,
  ...
}:
{
  home.packages =
    (with pkgs; [
      ## Graphical utilities
      qpwgraph
      mpv
      anytype
      grim
      slurp
      wl-clipboard
      hyprpicker
      hyprpaper
      watershot
      pavucontrol
      playerctl
      wev
      librewolf
      qbittorrent

      ## Gaming
      (prismlauncher.override { withWaylandGLFW = true; })
      glfw
      mangohud
      steam

      ## Creativity
      libreoffice-fresh
      gimp
      inkscape
      blender

      ## Communication (messengers)
      session-desktop
      kotatogram-desktop
      (vesktop.overrideAttrs (a: {
        desktopItems = map (
          d:
          d.override {
            exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland vesktop --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u";
          }
        ) a.desktopItems;
      }))
      (element-desktop.overrideAttrs (e: rec {
        # Add arguments to the .desktop entry
        desktopItem = e.desktopItem.override (d: {
          exec = "env NIXOS_OZONE_WL=1 element-desktop --disable-gpu-compositing %u";
        });

        # Update the install script to use the new .desktop entry
        installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
      }))
    ])
    ++ (with pkgs.libsForQt5; [
      okular
      ark
    ])
    ++ [
      zig.packages.${system}.master
      # zls.packages.${system}.default
    ];
  programs.obs-studio = {
    enable = false;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };
}
