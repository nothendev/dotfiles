{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
    pandoc
    session-desktop
    fd
    (jdt-language-server.override { jdk = pkgs.jdk17; })
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      input-overlay
      obs-pipewire-audio-capture
    ];
  };
}
