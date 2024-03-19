{ lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "pterodactyl-wings";
  version = "1.11.8";
  src = fetchFromGitHub {
    owner = "pterodactyl";
    repo = "wings";
    rev = "v${version}";
    sha256 = "sha256-JzbxROashDAL4NSeqMcWR9PgFqe9peBNpeofA347oE4=";
  };
  vendorHash = "sha256-fn+U91jX/rmL/gdMwRAIDEj/m0Zqgy81BUyv4El7Qxw=";
  subPackages = [ "." ];

  ldflags = [ "-X github.com/pterodactyl/wings/system.Version=${version}" ];
}
