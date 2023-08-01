{ lib, ... }:

{
  nixpkgs.overlays = map (x: import x) [ ./zig-nightly.nix ];
}
