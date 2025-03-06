{
  zig,
  pkgs,
  system,
  self,
  ...
}:
{
  services.syncthing.enable = true;
  home.packages =
    (with pkgs; [
      self.packages.${system}.winbox
      self.packages.${system}.bxt-launcher
      self.packages.${system}.zen-browser
      #self.packages.${system}.redot

      ## Just the one fucking time I had to install Windows 10 from uupdump.
      aria2
      cabextract
      wimlib
      chntpw
      cdrkit

      ## CAS - not compare and swap, but CONTAINERS AND SHIT ! :)
      docker-compose
      kompose
      kustomize
      kubectl
      kubernetes-helm
      fluxcd
      kind
      istioctl

      ## Graphical utilities
      kdenlive
      tenacity
      #ghidra
      jetbrains.idea-community
      code-cursor
      ghostty
      imhex
      unixtools.xxd
      thunderbird-128
      wlr-randr
      qpwgraph
      mpv
      blockbench
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
      unrar

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
      prismlauncher
      mangohud
      steam
      r2modman

      ## Creativity
      libreoffice-fresh
      gimp
      krita
      inkscape
      blender

      ## Communication (messengers)
      signal-desktop
      session-desktop
      (vesktop.overrideAttrs (a: {
        desktopItems = map (
          d:
          d.override {
            exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland vesktop --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u";
          }
        ) a.desktopItems;
      }))
      (legcord.overrideAttrs (a: {
        desktopItems = map (
          d:
          d.override {
            exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland legcord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u";
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

      ##
      freecad
      service-wrapper
      imagemagick
      (cutter.withPlugins (ps: with ps; [ rz-ghidra jsdec sigdb ]))
    ])
    ++ (with pkgs.libsForQt5; [
      okular
      ark
      dolphin
    ])
    ++ [
      zig.packages.${system}.master
    ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-freeze-filter
    ];
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
