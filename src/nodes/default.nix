{ nixpkgs, inputs }: {
  meta = {
    nixpkgs = import nixpkgs {
      system = "x86_64-linux";
    };
    specialArgs = inputs;
  };

  minky = ./minky.nix;
}
