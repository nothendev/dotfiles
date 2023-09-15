{ discord, nss }:
discord.override {
  withOpenASAR = true;
  withVencord = true;
  inherit nss;
}
