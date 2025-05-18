{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/dwl/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "MyPipewire"
      }
      playlist_plugin {
        name "m3u"
        enabled "true"
      }
    '';
    playlistDirectory = "/dwl/music/playlists";
    user = "ilya";
  };
  environment.systemPackages = with pkgs; [
    mpc-cli
  ];
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
}
