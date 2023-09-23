{ config, lib, pkgs, ... }:
let

  cfg = config.wayland.windowManager.hyprlandy;

in
{
  meta.maintainers = [ lib.maintainers.fufexan ];

  options.wayland.windowManager.hyprlandy = {
    enable = lib.mkEnableOption "Hyprland wayland compositor";

    plugins = lib.mkOption {
      type = with lib.types; listOf (either package path);
      default = [ ];
      description = ''
        List of Hyprland plugins to use. Can either be packages or
        absolute plugin paths.
      '';
    };

    systemdIntegration = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.isLinux;
      description = ''
        Whether to enable {file}`hyprland-session.target` on
        hyprland startup. This links to `graphical-session.target`.
        Some important environment variables will be imported to systemd
        and dbus user environment before reaching the target, including
        - `DISPLAY`
        - `HYPRLAND_INSTANCE_SIGNATURE`
        - `WAYLAND_DISPLAY`
        - `XDG_CURRENT_DESKTOP`
      '';
    };

    finalPackage = lib.mkPackageOption pkgs "hyprland" { };

    settings = lib.mkOption {
      type = with lib.types;
        let
          valueType = nullOr
            (oneOf [
              bool
              int
              float
              str
              path
              (attrsOf valueType)
              (listOf valueType)
            ]) // {
            description = "Hyprland configuration value";
          };
        in
        valueType;
      default = { };
      description = ''
        Hyprland configuration written in Nix. Entries with the same key
        should be written as lists. Variables' and colors' names should be
        quoted. See <https://wiki.hyprland.org> for more examples.

        ::: {.note}
        Use the [](#opt-wayland.windowManager.hyprland.plugins) option to
        declare plugins.
        :::

      '';
      example = lib.literalExpression ''
        {
          decoration = {
            shadow_offset = "0 5";
            "col.shadow" = "rgba(00000099)";
          };

          "$mod" = "SUPER";

          bindm = [
            # mouse movements
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];
        }
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = ''
        # window resize
        bind = $mod, S, submap, resize

        submap = resize
        binde = , right, resizeactive, 10 0
        binde = , left, resizeactive, -10 0
        binde = , up, resizeactive, 0 -10
        binde = , down, resizeactive, 0 10
        bind = , escape, submap, reset
        submap = reset
      '';
      description = ''
        Extra configuration lines to add to `~/.config/hypr/hyprland.conf`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "wayland.windowManager.hyprlandy" pkgs
        lib.platforms.linux)
    ];

    warnings =
      let
        inconsistent = (cfg.systemdIntegration || cfg.plugins != [ ])
          && cfg.extraConfig == "" && cfg.settings == { };
        warning =
          "You have enabled hyprland.systemdIntegration or listed plugins in hyprland.plugins but do not have any configuration in hyprland.settings or hyprland.extraConfig. This is almost certainly a mistake.";
      in
      lib.optional inconsistent warning;

    xdg.configFile."hypr/hyprland.conf" =
      let
        combinedSettings = cfg.settings // {
          plugin =
            let
              mkEntry = entry:
                if lib.types.package.check entry then
                  "${entry}/lib/lib${entry.pname}.so"
                else
                  entry;
            in
            map mkEntry cfg.plugins;
        };

        shouldGenerate = cfg.systemdIntegration || cfg.extraConfig != ""
          || combinedSettings != { };

        toHyprconf = with lib;
          attrs: indentLevel:
            let
              indent = concatStrings (replicate indentLevel "  ");

              mkSection = n: attrs: ''
                ${indent}${n} {
                ${toHyprconf attrs (indentLevel + 1)}${indent}}
              '';
              sections = filterAttrs (n: v: isAttrs v) attrs;

              mkFields = generators.toKeyValue {
                listsAsDuplicateKeys = true;
                inherit indent;
              };
              allFields = filterAttrs (n: v: !(isAttrs v)) attrs;
              importantFields =
                filterAttrs (n: _: (hasPrefix "$" n) || (hasPrefix "bezier" n))
                  allFields;
              fields = builtins.removeAttrs allFields
                (mapAttrsToList (n: _: n) importantFields);
            in
            mkFields importantFields
            + concatStringsSep "\n" (mapAttrsToList mkSection sections)
            + mkFields fields;
      in
      lib.mkIf shouldGenerate {
        text = lib.optionalString cfg.systemdIntegration ''
          exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target
        '' + lib.optionalString (combinedSettings != { })
          (toHyprconf combinedSettings 0)
        + lib.optionalString (cfg.extraConfig != "") cfg.extraConfig;
        onChange = ''
          (  # execute in subshell so that `shopt` won't affect other scripts
            shopt -s nullglob  # so that nothing is done if /tmp/hypr/ does not exist or is empty
            for instance in /tmp/hypr/*; do
              HYPRLAND_INSTANCE_SIGNATURE=''${instance##*/} ${cfg.finalPackage}/bin/hyprctl reload config-only \
                || true  # ignore dead instance(s)
            done
          )
        '';
      };

    systemd.user.targets.hyprland-session = lib.mkIf cfg.systemdIntegration {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
  };
}
