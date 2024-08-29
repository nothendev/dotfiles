{
  zig,
  pkgs,
  system,
  ...
}:
{
  services.syncthing.enable = true;
  home.packages =
    (with pkgs; [
      ## JAVA !! yeee
      zulu17
      ## Graphical utilities
      thunderbird-128
      wlr-randr
      qpwgraph
      mpv
      #anytype #they fucked something up :) vendoring goes brrrrrrrrr
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
      (brave.overrideAttrs (old: {
        postInstall = ''
          substituteInPlace $out/share/applications/brave-browser.desktop \
            --replace "$out/bin/brave" "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland $out/bin/brave --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing"
        '';
      }))
      qbittorrent

      ## Note taking and organization
      (obsidian.overrideAttrs (e: rec {
        # Add arguments to the .desktop entry
        desktopItem = e.desktopItem.override (d: {
          exec = "env NIXOS_OZONE_WL=1 obsidian --disable-gpu-compositing %u";
        });

        # Update the install script to use the new .desktop entry
        installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
      }))

      ## Gaming
      (prismlauncher.override { withWaylandGLFW = false; })
      glfw-wayland-minecraft
      mangohud
      steam
      r2modman

      ## Creativity
      libreoffice-fresh
      gimp
      inkscape
      blender

      ## Communication (messengers)
      signal-desktop
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
      minikube
      kubectl
      kubernetes-helm
      linkerd_edge
      istioctl
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
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
