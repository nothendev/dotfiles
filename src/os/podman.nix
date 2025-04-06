{ pkgs, ... }:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true; # alias `podman` to `docker` for compat
      defaultNetwork.settings.dns_enabled = true; # let containers under podman-compose talk to each other (enable dns)
    };
    oci-containers.backend = "podman";
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    dive
    podman-tui
  ];
}
