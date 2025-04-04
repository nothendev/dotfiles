{
  stdenv,
  lib,
  fetchFromGitHub,
  pkg-config,
  autoPatchelfHook,
  installShellFiles,
  scons,
  vulkan-loader,
  libGL,
  libX11,
  libXcursor,
  libXinerama,
  libXext,
  libXrandr,
  libXrender,
  libXi,
  libXfixes,
  libxkbcommon,
  alsa-lib,
  libpulseaudio,
  dbus,
  speechd,
  fontconfig,
  udev,
  withDebug ? false,
  withPlatform ? "linuxbsd",
  withTarget ? "editor",
  withPrecision ? "single",
  withPulseaudio ? true,
  withDbus ? true,
  withSpeechd ? true,
  withFontconfig ? true,
  withUdev ? true,
  withTouch ? true,
}:

assert lib.asserts.assertOneOf "withPrecision" withPrecision [
  "single"
  "double"
];

let
  mkSconsFlagsFromAttrSet = lib.mapAttrsToList (
    k: v: if builtins.isString v then "${k}=${v}" else "${k}=${builtins.toJSON v}"
  );
in
stdenv.mkDerivation rec {
  pname = "redot";
  version = "redot-4.3";
  commitHash = "92225b33c283bff14c105c4d44c22a831601721b";

  src = fetchFromGitHub {
    owner = "Redot-Engine";
    repo = "redot-engine";
    rev = commitHash;
    #hash = "sha256-t+MbM16y5B9PKCykVmUEfQ+wn9IEJByoD/B7+UsZVvQ=";
    sha256 = "1x2n355zjyzh1yl1q904sagv03vx0ijmd91c517izr5jbqripqxp";
  };

  nativeBuildInputs = [
    pkg-config
    autoPatchelfHook
    installShellFiles
  ];

  buildInputs = [
    scons
  ];

  runtimeDependencies =
    [
      vulkan-loader
      libGL
      libX11
      libXcursor
      libXinerama
      libXext
      libXrandr
      libXrender
      libXi
      libXfixes
      libxkbcommon
      alsa-lib
    ]
    ++ lib.optional withPulseaudio libpulseaudio
    ++ lib.optional withDbus dbus
    ++ lib.optional withDbus dbus.lib
    ++ lib.optional withSpeechd speechd
    ++ lib.optional withFontconfig fontconfig
    ++ lib.optional withFontconfig fontconfig.lib
    ++ lib.optional withUdev udev;

  enableParallelBuilding = true;

  BUILD_NAME = "nixpkgs";

  # Required for the commit hash to be included in the version number.
  #
  # `methods.py` reads the commit hash from `.git/HEAD` and manually follows
  # refs. Since we just write the hash directly, there is no need to emulate any
  # other parts of the .git directory.
  #
  # See also 'hash' in
  preConfigure = ''
    mkdir -p .git
    echo ${commitHash} > .git/HEAD
  '';

  sconsFlags = mkSconsFlagsFromAttrSet {
    # Options from 'SConstruct'
    production = true; # Set defaults to build Redot for use in production
    platform = withPlatform;
    target = withTarget;
    precision = withPrecision; # Floating-point precision level
    debug_symbols = withDebug;

    # Options from 'platform/linuxbsd/detect.py'
    pulseaudio = withPulseaudio; # Use PulseAudio
    dbus = withDbus; # Use D-Bus to handle screensaver and portal desktop settings
    speechd = withSpeechd; # Use Speech Dispatcher for Text-to-Speech support
    fontconfig = withFontconfig; # Use fontconfig for system fonts support
    udev = withUdev; # Use udev for gamepad connection callbacks
    touch = withTouch; # Enable touch events
  };

  dontStrip = withDebug;

  outputs = [
    "out"
    "man"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp bin/redot.* $out/bin/

    installManPage misc/dist/linux/godot.6

    mkdir -p "$out"/share/{applications,icons/hicolor/scalable/apps}
    cp misc/dist/linux/org.redotengine.Redot.desktop "$out/share/applications/org.redotengine.Redot.desktop"
    substituteInPlace "$out/share/applications/org.redotengine.Redot.desktop" \
      --replace "Exec=redot" "Exec=$out/bin/redot.linuxbsd.editor.x86_64" \
      --replace "Redot Engine" "redot Engine"
    cp icon.svg "$out/share/icons/hicolor/scalable/apps/redot.svg"
    cp icon.png "$out/share/icons/redot.png"

    runHook postInstall
  '';

  meta = {
    homepage = "https://redotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license = lib.licenses.mit;
    platforms = [
      "i686-linux"
      "x86_64-linux"
      "aarch64-linux"
    ];
    maintainers = with lib.maintainers; [ shiryel ];
    mainProgram = "redot4.3beta3";
  };
}
