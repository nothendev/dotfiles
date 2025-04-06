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
  nixpkgs.config.permittedInsecurePackages = [
    "SDL_ttf-2.0.11"
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    gtk3
    bashInteractive
    zenity
    xorg.xrandr
    which
    perl
    xdg-utils
    iana-etc
    krb5
    gsettings-desktop-schemas
    hicolor-icon-theme # dont show a gtk warning about hicolor not being installed
    desktop-file-utils
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    libGL

    gst_all_1.gstreamer
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-base
    libdrm
    xorg.xkeyboardconfig
    xorg.libpciaccess

    glib
    gtk2
    bzip2
    zlib
    gdk-pixbuf

    xorg.libXinerama
    xorg.libXdamage
    xorg.libXcursor
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXxf86vm
    xorg.libXi
    xorg.libSM
    xorg.libICE
    freetype
    curlWithGnuTls
    nspr
    nss
    fontconfig
    cairo
    pango
    expat
    dbus
    cups
    libcap
    SDL2
    libusb1
    udev
    dbus-glib
    atk
    at-spi2-atk
    libudev0-shim

    xorg.libXt
    xorg.libXmu
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilwm
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    libGLU
    libuuid
    libogg
    libvorbis
    SDL2_image
    glew110
    openssl
    libidn
    tbb
    wayland
    libgbm
    libxkbcommon
    vulkan-loader

    flac
    libglut
    libjpeg
    libpng12
    libpulseaudio
    libsamplerate
    libmikmod
    libthai
    libtheora
    libtiff
    pixman
    speex
    SDL2_ttf
    SDL2_mixer
    libappindicator-gtk2
    libcaca
    libcanberra
    libgcrypt
    libvpx
    librsvg
    xorg.libXft
    libvdpau
    alsa-lib

    harfbuzz
    e2fsprogs
    libgpg-error
    keyutils.lib
    libjack2
    fribidi
    p11-kit

    gmp

    # libraries not on the upstream include list, but nevertheless expected
    # by at least one appimage
    libtool.lib # for Synfigstudio
    at-spi2-core
    pciutils # for FreeCAD
    pipewire # immersed-vr wayland support

    libsecret # For bitwarden
    libmpg123 # Slippi launcher
  ];
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
    gnumake
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
