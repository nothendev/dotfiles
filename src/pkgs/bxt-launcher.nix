{
  lib,
  stdenv,
  fetchzip,
  wrapGAppsHook3,
  glib,
  libgtop,
  autoPatchelfHook
}:
stdenv.mkDerivation {
  pname = "bxt-launcher";
  version = "0.2";
  #src = fetchFromGitHub {
  #  owner = "YaLTeR";
  #  repo = "bxt-launcher";
  #  rev = "v${version}";
  #  hash = "sha256-Csw2CUQLKCvg75n1sMFozBvjxgqF6M4chSxQPTLMiC4=";
  #};
  src = fetchzip {
    url = "https://github.com/YaLTeR/bxt-launcher/releases/download/v0.2/bxt-launcher.zip";
    hash = "sha256-TkrU4sLzM4lpjAHPIzyF7PwbROwdsan+FSklRvqZ1pY=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    wrapGAppsHook3
    autoPatchelfHook
  ];

  buildInputs = [
    glib
    libgtop
  ];

  installPhase = ''
    runHook preInstall
    install -m755 -D bxt-launcher $out/bin/bxt-launcher
    cp libBunnymodXT.so gschemas.compiled $out/bin/
    runHook postInstall
  '';

  env.NIX_CFLAGS_COMPILE = lib.optionalString stdenv.cc.isClang "-Wno-error=int-conversion";

  meta = {
    description = "GUI launcher for Bunnymod XT on Linux ";
    homepage = "https://github.com/YaLTeR/bxt-launcher";
  };
}
