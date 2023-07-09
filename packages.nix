{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty emacs neovim fish starship
    bat htop jq socat wget curl macchanger
    exa ffmpeg acpi git just

    wayland xdg-utils grim slurp wl-clipboard gnome.gdm
    rofi-wayland-unwrapped eww-wayland hyprpicker hyprpaper
    watershot pavucontrol

    opera

    distrobox meson ninja
    nodejs go cargo
  ];
}
