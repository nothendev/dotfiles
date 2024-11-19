{ pkgs, ... }:
let
  pacscript = pkgs.writeText "proxy.pac" ''
    function FindProxyForURL(url, host) {
        return "SOCKS 127.0.0.1:1080";
    }
  '';
  nmcli = "${pkgs.networkmanager}/bin/nmcli";
  connection = "eth";
in
{
  systemd.services.byedpi = {
    description = "byedpi";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.byedpi}/bin/ciadpi --debug 1 --disorder 1 -At -r1+s -f-1";
      Restart = "always";
    };
  };
}
