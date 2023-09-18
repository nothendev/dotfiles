{ stdenv
, lib
, fetchzip
, autoPatchelfHook
,
}:
stdenv.mkDerivation rec {
  pname = "focalboard";
  version = "0.15.0";

  src = fetchzip {
    url = "https://github.com/mattermost/focalboard/releases/download/v${version}/focalboard-server-linux-amd64.tar.gz";
    sha256 = "1xbigsh4y09l5axxvzq7gx6cng8xmz7vdwbwv2rl4kbcy72j4pbc";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  # dontFixup = true;

  installPhase = ''
    cp -r $src $out
    substituteInPlace $out/config.json --replace ./pack $out/pack
    substituteInPlace $out/config.json --replace "''\t" "    "
    runHook postInstall
  '';

  meta = with lib; {
    description = "Focalboard is an open source, self-hosted alternative to Trello, Notion, and Asana.";
    homepage = "https://github.com/mattermost/focalboard";
    platforms = platforms.all;
  };
}
