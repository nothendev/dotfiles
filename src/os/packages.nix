{
  config,
  pkgs,
  nixpkgs,
  zls,
  zig,
  ...
}:
{
  imports = [ ../overlays ];
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.registry.nixpkgs.to = {
    type = "path";
    path = pkgs.path;
  };
  programs.nix-ld.enable = true;
  environment.variables = {
    NIX_LD = pkgs.lib.mkForce pkgs.stdenv.cc.bintools.dynamicLinker;
  };
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
  environment.etc."jvm/17".source = pkgs.jdk17;
  environment.etc."jvm/8".source = pkgs.jdk8;
  environment.systemPackages = with pkgs; [
    glibc
    (btop.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ addOpenGLRunpath ];
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
    bun

    nh
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
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
