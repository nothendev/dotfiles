{ config, pkgs, fjo, system, ... }:
{
  home.packages = with pkgs; [
    qpwgraph
    eza
    pandoc
    session-desktop
    fd
    mpv
    anytype
    blender
    # firefox
    ## broken build
    kotatogram-desktop
    fjo.packages.${system}.default
    evcxr
    colmena
    # telegram-desktop
    xdg-utils
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
    cachix
    rnix-lsp
    nixfmt
    prismlauncher
    qbittorrent
    ranger
    steam
    canon-cups-ufr2

    libreoffice-fresh
    gimp
    # krita
    inkscape
    gnome.nautilus
    # wineWowPackages.waylandFull
    # glfw-minecraft
    glfw
    # blender
    # obsidian
    mangohud
    # I HATE NVIDIA I HATE NVIDIA I HATE NVIDIA
    (vesktop.overrideAttrs
      (a: { desktopItems = map (d: d.override { exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland vesktop --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u"; }) a.desktopItems; }))
    (element-desktop.overrideAttrs
      (e: rec {
        # Add arguments to the .desktop entry
        desktopItem = e.desktopItem.override (d: {
          exec = "env NIXOS_OZONE_WL=1 element-desktop --disable-gpu-compositing %u";
        });

        # Update the install script to use the new .desktop entry
        installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
      }))
  ];
  programs.obs-studio = {
    enable = false;
    package = (pkgs.obs-studio.override { ffmpeg_4 = pkgs.ffmpeg_4-full; }).overrideAttrs (a: { cmakeFlags = a.cmakeFlags ++ [ "-DENABLE_AJA=0" ]; });
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      input-overlay
      obs-pipewire-audio-capture
    ];
  };
}
