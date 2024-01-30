{ config, pkgs, fjo, system, ... }:
{
  home.packages = with pkgs; [
    eza
    pandoc
    session-desktop
    fd
    (jdt-language-server.override { jdk = pkgs.jdk17; })
    mpv
    anytype
    blender
    # firefox
    ## broken build
    kotatogram-desktop
    fjo.packages.${system}.default
    evcxr
    (webcord-vencord.overrideAttrs
      (a: { desktopItems = map (d: d.override { exec = "env NIXOS_OZONE_WL=1 webcord --disable-gpu-compositing %u"; }) a.desktopItems; }))
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
