rebuild:
  git add .
  git commit -m "[justfile] stage objects"
  sudo nixos-rebuild switch --flake .
