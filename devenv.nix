{ pkgs, ... }:

{
  scripts.stage.exec = "git add .; git commit -m '[devenv] auto-commit'";
  scripts.push.exec = "stage; git commit --amend -m $1; git push gh";

  pre-commit.hooks.nixfmt.enable = true;
}
