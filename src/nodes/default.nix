{ nixpkgs, inputs }: {
  meta = {
    nixpkgs = import nixpkgs { system = "x86_64-linux"; };
    specialArgs = inputs;
  };

  binkus = ./binkus.nix;
  minky = ./minky.nix;
}
