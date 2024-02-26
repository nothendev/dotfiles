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
      (btop.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [addOpenGLRunpath];
        postFixup = ''
          addOpenGLRunpath $out/bin/btop
        '';
      }))
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
      gcc13
      alsa-lib
      udev
      wayland
      xorg.libX11
      xorg.libXcursor
      mold-wrapped
      nodejs_18

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
