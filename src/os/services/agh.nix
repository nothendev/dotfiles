{ pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    port = 9837;
  };
}
