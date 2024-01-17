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
    fjo.packages.${system}.default
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
