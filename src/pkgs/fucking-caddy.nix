{ pkgs, lib, stdenv, git, go, xcaddy }:
stdenv.mkDerivation rec {
  pname = "caddy";
  # https://github.com/NixOS/nixpkgs/issues/113520
  version = "latest";
  dontUnpack = true;

  nativeBuildInputs = [ git go xcaddy ];

  configurePhase = ''
    export GOCACHE=$TMPDIR/go-cache
    export GOPATH="$TMPDIR/go"
  '';

  buildPhase = ''
    runHook preBuild
    XCADDY_SUDO=0 ${xcaddy}/bin/xcaddy build v2.8.4 --with github.com/mholt/caddy-l4@6a8be7c4b8acb0c531b6151c94a9cd80894acce1 --with github.com/caddy-dns/cloudflare
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv caddy $out/bin
    runHook postInstall
  '';

  meta.mainProgram = "caddy";
}
