prev: final:
{
  glfw-minecraft = prev.glfw.override (old: rec {
    patches = old.patches ++ [ ./0003.patch ./0004.patch ./0005.patch ./0006.patch ./0007.patch ];
  });
}
