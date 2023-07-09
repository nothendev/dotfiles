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
    ffmpeg
    acpi
    git
    gh
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
    wev

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
    rustup

    cachix
    rnix-lsp
    nixfmt

    prismlauncher
  ];
}
