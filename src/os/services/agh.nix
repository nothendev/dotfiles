{ pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    settings.bind_port = 9837;
  };
}
