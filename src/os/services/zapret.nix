{
  pkgs,
  ...
}:
{
  systemd.services.zapret = {
    description = "zapret daemon";
    path = with pkgs; [
      nftables
      curl
      iptables
      coreutils
      util-linux
    ];

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "forking";
      Restart = "no";
      KillMode = "none";
      GuessMainPID = "no";
      RemainAfterExit = "no";
      IgnoreSIGPIPE = "no";
      TimeoutSec = "30sec";
      ExecStart = ''
        /opt/zapret/init.d/sysv/zapret start
      '';
      ExecStop = ''
        /opt/zapret/init.d/sysv/zapret stop
      '';
    };
  };
}
