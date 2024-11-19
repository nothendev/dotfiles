{
  pkgs ? import <nixpkgs> { },
  overrides ? (self: super: { }),
}:
with pkgs;
let
  packages =
    self:
    let
      callPackage = newScope self;
    in
    {
      graalvmPackages = callPackage ./graalvm { };
    };
in
lib.fix (lib.extends overrides packages)
