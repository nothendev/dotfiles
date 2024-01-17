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
      fish
      starship
      glibc

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
      (element-desktop.overrideAttrs
        (e: rec {
          # Add arguments to the .desktop entry
          desktopItem = e.desktopItem.override (d: {
            exec = "env NIXOS_OZONE_WL=1 element-desktop --disable-gpu-compositing %u";
          });

          # Update the install script to use the new .desktop entry
          installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
        }))
      xdg-utils
      grim
      slurp
      wl-clipboard
      hyprpicker
      hyprpaper
      watershot
      pavucontrol
      playerctl
      wev
      # (discord.overrideAttrs (why: { desktopItem = why.desktopItem.override (guh: { exec = "${guh.exec} --enable-gpu-rasterization --enable-zero-copy --enable-gpu-compositing --enable-native-gpu-memory-buffers --enable-oop-rasterization --enable-features=UseSkiaRenderer,WaylandWindowDecorations --ozone-platform-hint=auto --use-vulkan"; }); }))

      # brave
      librewolf

      # distrobox
      meson
      ninja
      cmake
      go
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
      # nodejs_18

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
      # krita
      inkscape
      gnome.nautilus
      # wineWowPackages.waylandFull
      # glfw-minecraft
      glfw
      # blender
      # obsidian
      mangohud

      nh
    ] ++ (with libsForQt5; [ okular ark ]) ++ [
      zig.packages.${pkgs.system}.master
      # zls.packages.${pkgs.system}.default
    ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings.general.renice = 10;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };
}
