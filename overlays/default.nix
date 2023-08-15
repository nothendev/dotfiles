{ zig, ... }:

{
  nixpkgs.overlays = [ zig.overlays.default ]
    ++ (map (x: import x) [ ./zig-nightly.nix ./glfw-minecraft ]);
}
