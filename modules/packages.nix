{ config, pkgs, nixpkgs, zls, zig, ... }: {
  imports = [ ../overlays ];
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.nixPath = [ "nixpkgs=/etc/channels/nixpkgs" ];
  environment.etc."channels/nixpkgs".source = nixpkgs.outPath;
  environment.etc."jvm/17".source = pkgs.jdk17;
  environment.etc."jvm/8".source = pkgs.jdk8;
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
      insomnia

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
      gdb
      lldb
      patchelf
      zip
      unzip
      ripgrep
      tokei
      python3

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
      krita
    ] ++ (with libsForQt5; [ okular dolphin ]) ++ [
      zig.packages.${pkgs.system}.master
      zls.packages.${pkgs.system}.default
    ];
}
