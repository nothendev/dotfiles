{
  config,
  pkgs,
  nixpkgs,
  zls,
  zig,
  ...
}:
{
  imports = [
    ./java.nix
  ];
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
  environment.systemPackages = with pkgs; [
    glibc
    #(btop.overrideAttrs (old: {
    #  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ addOpenGLRunpath ];
    #  postFixup = ''
    #    addOpenGLRunpath $out/bin/btop
    #  '';
    #}))
    btop
    nmap
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
    meson
    ninja
    cmake
    go_1_23
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

  environment.variables.NIXOS_OZONE_WL = "1";
}
