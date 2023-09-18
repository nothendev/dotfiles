{ appimageTools, lib, fetchurl }:
let
  pname = "io.gitlab.LibreWolf";
  version = "116.0-1";
  arch = "x86_64";
  name = "LibreWolf.${arch}";
  src = fetchurl {
    url = "https://gitlab.com/api/v4/projects/24386000/packages/generic/librewolf/${version}/${name}.AppImage";
    sha256 = "4e4c88e7143daffd5375974c8046c68911d485935022d8cc98de83a89769293f";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/librewolf
    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=env GDK_BACKEND=wayland MOZ_ENABLE_WAYLAND=1 librewolf'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "A custom version of Firefox, focused on privacy, security and freedom.";
    homepage = "https://codeberg.org/librewolf/source";
    license = licenses.mpl20;
    platforms = [ "${arch}-linux" ];
  };
}
