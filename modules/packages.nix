{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    emacs
    neovim
    fish
    starship

    bat
    htop
    jq
    socat
    wget
    curl
    macchanger
    exa
    ffmpeg
    acpi
    git
    just
    neofetch

    wayland
    xdg-utils
    grim
    slurp
    wl-clipboard
    gnome.gdm
    rofi-wayland-unwrapped
    eww-wayland
    hyprpicker
    hyprpaper
    watershot
    pavucontrol
    playerctl

    opera
    brave
    vivaldi

    distrobox
    meson
    ninja
    cmake
    nodejs
    go
    cargo

    cachix
    rnix-lsp
    nixfmt

    prismlauncher
  ];
}
