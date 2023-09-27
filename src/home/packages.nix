{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
    logseq
    pandoc
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