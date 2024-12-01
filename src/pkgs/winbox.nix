{
  lib,
  stdenv,
  fetchzip,
  makeDesktopItem,
  autoPatchelfHook,
  libGL,
  libz,
  freetype,
  fontconfig,
  libxkbcommon,
  libxcb,
  xcbutilwm,
  xcbutilimage,
  xcbutilrenderutil,
}:
stdenv.mkDerivation rec {
  pname = "winbox";
  version = "4.0beta9";
  src = fetchzip {
    url = "https://download.mikrotik.com/routeros/${pname}/${version}/WinBox_Linux.zip";
    hash = "sha256-NpkKnU7kW8jMKq66FqwiuD2N5zm25uKCZBhHvHnfQVI=";
    stripRoot = false;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    libGL
    libz
    freetype
    fontconfig
    libxkbcommon
    libxcb
    xcbutilwm
    xcbutilimage
    xcbutilrenderutil
  ];
  installPhase = ''
    runHook preInstall
    install -m755 -D WinBox $out/bin/winbox
    mkdir -p $out/share/pixmaps
    ln -s $out/assets/winbox/winbox.png $out/share/pixmaps/winbox.png
    runHook postInstall
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "WinBox";
      exec = "winbox";
      icon = "winbox";
      desktopName = "WinBox";
      comment = "MikroTik WinBox";
      categories = [ "Network" ];
      type = "Application";
    })
  ];

  meta = with lib; {
    description = "Graphical configuration utility for RouterOS-based devices";
    homepage = "https://www.mikrotik.com";
    downloadPage = "https://www.mikrotik.com/download";
    changelog = "https://wiki.mikrotik.com/wiki/Winbox_changelog";
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "winbox";
  };
}