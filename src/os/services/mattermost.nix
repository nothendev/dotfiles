{
  lib,
  mattermost-plugin-focalboard,
  mattermost-plugin-jitsi,
  ...
}:
{
  services.mattermost = {
    enable = true;
    siteUrl = "https://mm.passivity.trading";
    siteName = "Passivity";
    mutableConfig = true;
    localDatabaseCreate = true;
    user = "mattermost";
    plugins = [
      mattermost-plugin-focalboard
      mattermost-plugin-jitsi
    ];
  };
  services.nginx = {
    enable = lib.mkDefault true;
  };
}
