{ pkgs ? import <nixpkgs> { }
, overrides ? (self: super: { })
,
}:
with pkgs; let
  packages = self:
    let
      callPackage = newScope self;
    in
    {
      focalboard = callPackage ./focalboard.nix { };
      librewolf-appimage = callPackage ./librewolf.nix { };
    };
in
lib.fix (lib.extends overrides packages)
