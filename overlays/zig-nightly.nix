final: prev: rec {
  zig = (prev.zig.overrideAttrs (old: {
    version = "0.11.0-dev.4333+4f6013bf5";
    src = prev.fetchFromGitHub {
      owner = "ziglang";
      repo = "zig";
      rev = "4f6013bf50e1b99b5c9ea238a2165bfe41fc57d4";
      hash = "sha256-G/SrvgYojIkGREJ455ooFyX1I1xJKdKF2Yw16v/qZX4=";
    };
    patches = [ ];
  })).override { llvmPackages = prev.llvmPackages_16; };
  zls = (prev.zls.overrideAttrs (old: {
    version = "0.11.0-dev.4333+f71c42b42";
    src = prev.fetchFromGitHub {
      owner = "zigtools";
      repo = "zls";
      rev = "f71c42b42d15a02b515806ab4226868180e33b67";
      hash = "sha256-cDPEG4LlAo0FCDoAn9sMABcKuDnTwhMKc1il2odg3pg=";
    };
  })).override { inherit zig; };
}
