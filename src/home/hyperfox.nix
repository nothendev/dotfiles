{ config, pkgs, osConfig, ff-cascade, ... }: {
  programs.firefox = {
    enable = false;
    profiles.explodus = {
      isDefault = true;
      name = "explodus";
      extraConfig = "${builtins.readFile ./user.js}";
      userChrome =
        let b = osConfig.pretty.base69;
        includes = "${ff-cascade}/chrome/includes"; in ''
      @import '${includes}/cascade-config.css';

      @import '${includes}/cascade-layout.css';
      @import '${includes}/cascade-responsive.css';
      @import '${includes}/cascade-floating-panel.css';

      @import '${includes}/cascade-nav-bar.css';
      @import '${includes}/cascade-tabs.css';
      @import '${ff-cascade}/integrations/tabcenter-reborn/cascade-tcr.css';

      :root {
        --uc-identity-colour-blue: ${b.blue};
        --uc-identity-colour-turquoise: ${b.teal};
        --uc-identity-colour-green: ${b.green};
        --uc-identity-colour-yellow: ${b.yellow};
        --uc-identity-colour-orange: ${b.peach};
        --uc-identity-colour-red: ${b.red};
        --uc-identity-colour-pink: ${b.pink};
        --uc-identity-colour-purple: ${b.mauve};

        --uc-base-colour: ${b.base};
        --uc-highlight-colour: ${b.overlay1};
        --uc-inverted-colour: ${b.text};
        --uc-muted-colour: ${b.surface1};
        --uc-accent-color: ${b.sapphire};
        --uc-urlbar-min-width: 0vw;
        --uc-urlbar-max-width: 100vw;
      }
      '';
    };
  };
}
