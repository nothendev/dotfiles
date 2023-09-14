{ appimageTools, lib, fetchurl }:
let
  pname = "io.gitlab.LibreWolf";
  version = "117.0-1";
  arch = "x86_64";
  name = "LibreWolf.${arch}";
  src = fetchurl {
    url = "https://gitlab.com/api/v4/projects/24386000/packages/generic/librewolf/${version}/${name}.AppImage";
    sha256 = "26c80f59137681aed9f40f58c8f49f18bd329c94c680de9d5c0e10ebd2f2a580";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=librewolf'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "A custom version of Firefox, focused on privacy, security and freedom.";
    homepage = "https://codeberg.org/librewolf/source";
    license = licenses.mpl20;
    platforms = [ "${arch}-linux" ];
  };
}
