{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;
  users.users.ilya.extraGroups = [ "docker" ];
}
