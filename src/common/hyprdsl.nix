{ lib }:
rec {
  dir = {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    forward = "f";
    back = "b";
  };

  window = {
    class = regex: "${regex}";
    title = regex: "title:${regex}";
    pid = pid: "pid:${pid}";
    addr = addr: "address:${addr}";
  };

  monitor = {
    inherit dir;
    id = id: "${toString id}";
    name = name: "${name}";
    current = "current";
    inherit relative;
  };

  perc = n: "${toString n}%";

  resizeparams = x: y: "${toString x} ${toString y}";

  relative = rel: if rel > 0 then "+${toString rel}" else "-${toString rel}";

  float = {
    inherit relative;
    exact = n: "exact ${toString n}";
  };

  workspace' = {
    id = n: "${toString n}";
    inherit relative;
    relative-monitor = rel: "m${relative rel}";
    relative-monitor' = rel: "r${relative rel}";
    relative-open = rel: "e${relative rel}";
    name = name: "name:${name}";
    previous = "previous";
    first-empty = "empty";
    special = "special";
    special' = name: "special:${name}";
  };

  workspaceopt' = {
    all-float = "allfloat";
    all-pseudo = "allpseudo";
  };

  fn =
    let
      func = name: args: "${lib.strings.removeSuffix "'" name}, ${lib.concatStringsSep ", " (map (toString) (if builtins.isList args then args else [args]))}";
      named = names: lib.attrsets.genAttrs names (name: lib.strings.removeSuffix "'" name);
      singlearg = names: lib.attrsets.genAttrs names (name: (arg1: (func name [ arg1 ])));
      doublearg = names: lib.attrsets.genAttrs names (name: (arg1: arg2: (func name [ arg1 arg2 ])));
    in
    {
      centerwindow1 = func "centerwindow" [ 1 ];
    }

    // named [
      "togglespecialworkspace"
      "killactive"
      "togglefloating"
      "fullscreen"
      "fakefullscreen"
      "pin"
      "centerwindow"
      "exit"
      "forcerendererreload"
      "bringactivetotop"
      "focusurgentorlast"
      "togglegroup"
      "focuscurrentorlast"
      "pseudo"
      "togglesplit"
      "moveoutofgroup"
      "movewindow'"
      "resizewindow'"
    ]

    // singlearg [
      "exec"
      "execr"
      "pass"
      "closewindow"
      "workspace"
      "movetoworkspace"
      "movetoworkspacesilent"
      "togglefloating'"
      "togglespecialworkspace'"
      "fullscreen'"
      "dpms"
      "pin'"
      "movefocus"
      "movewindow"
      "swapwindow"
      "changegroupactive"
      "lockgroups"
      "lockactivegroup"
      "moveintogroup"
      "movewindoworgroup"
      "movegroupwindow"
    ]

    // doublearg [
      "movetoworkspace'"
      "movetoworkspacesilent'"
    ];

  env = var: value: "${var}, ${toString value}";
  bind = mods: keys: action: "${if mods == null then "" else if lib.isString mods then mods else lib.concatStringsSep " " mods}, ${if lib.isString keys then keys else lib.concatStringsSep " " keys}, ${action}";
}
