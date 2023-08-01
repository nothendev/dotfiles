{ config, pkgs, nixpkgs, ... }: {
  imports = [ ../overlays ];
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.nixPath = [ "nixpkgs=/etc/channels/nixpkgs" ];
  environment.etc."channels/nixpkgs".source = nixpkgs.outPath;
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

      # brave
      librewolf

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
      zig
      zls

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
