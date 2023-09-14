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
      nmon
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
      # telegram-desktop
      kotatogram-desktop

      xdg-utils
      grim
      slurp
      wl-clipboard
      rofi-wayland-unwrapped
      (eww-wayland.override { withWayland = true; })
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
      go
      cargo
      rustup
      libclang
      gdb
      lldb
      patchelf
      zip
      unzip
      ripgrep
      tokei
      python3
      pkg-config
      gcc
      alsa-lib
      udev
      wayland
      xorg.libX11
      xorg.libXcursor
      mold
      nodejs_18
      blockbench-electron

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
      inkscape
      gnome.nautilus
      # wineWowPackages.waylandFull
      glfw-minecraft
      blender
      # obsidian
    ] ++ (with libsForQt5; [ okular ark ]) ++ [
      zig.packages.${pkgs.system}.master
      # zls.packages.${pkgs.system}.default
    ];
}
