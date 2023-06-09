{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
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

      brave

      distrobox
      meson
      ninja
      cmake
      nodejs
      go
      cargo
      rustup
      gcc
      clang

      cachix
      rnix-lsp
      nixfmt

      prismlauncher
      qbittorrent
      ranger
      steam
      canon-cups-ufr2

      libreoffice-fresh
    ] ++ (with libsForQt5; [ okular dolphin ]);
}
