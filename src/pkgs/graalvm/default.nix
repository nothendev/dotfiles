{ callPackage }:
rec {
  buildGraalvm = callPackage ./buildGraalvm.nix;

  graalvm-oracle_22 = callPackage ./graalvm-oracle { version = "22"; inherit buildGraalvm; };
  graalvm-oracle_17 = callPackage ./graalvm-oracle { version = "17"; inherit buildGraalvm; };
  graalvm-oracle = graalvm-oracle_22;
}
