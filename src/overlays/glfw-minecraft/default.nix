prev: final: {
  glfw-minecraft = (prev.glfw.override { waylandSupport = true; }).overrideAttrs (old: rec {
    patches = old.patches ++ [
      ./0003.patch
      ./0004.patch
      ./0005.patch
      # ./0006.patch
      ./0007.patch
    ];
    src = prev.fetchFromGitHub {
      owner = "glfw";
      repo = "GLFW";
      rev = "62e175ef9fae75335575964c845a302447c012c7";
      sha256 = "sha256-GiY4d7xadR0vN5uCQyWaOpoo2o6uMGl1fCcX4uDGnks=";
    };
    cmakeFlags = [
      "-DBUILD_SHARED_LIBS=ON"
      "-DGLFW_USE_WAYLAND=ON"
      "-DGLFW_BUILD_X11=OFF"
      "-DCMAKE_C_FLAGS=-D_GLFW_EGL_LIBRARY='\"${prev.lib.getLib prev.libGL}/lib/libEGL.so.1\"'"
    ];
  });
}
