final: prev: {
  zig = prev.zig.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "ziglang";
      repo = "zig";
      rev = "4f6013bf50e1b99b5c9ea238a2165bfe41fc57d4";
      hash = "sha256-G/SrvgYojIkGREJ455ooFyX1I1xJKdKF2Yw16v/qZX4=";
    };
  });
  zls = prev.zls.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "zigtools";
      repo = "zls";
      rev = "f71c42b42d15a02b515806ab4226868180e33b67";
      hash = "sha256-cDPEG4LlAo0FCDoAn9sMABcKuDnTwhMKc1il2odg3pg=";
    };
  });
}
