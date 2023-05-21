function nhyprutil
  switch $argv[1]
    case "mainkeyboard"
      echo "microsoft-wired-keyboard-600"
    case "kbswitch"
      hyprctl switchxkblayout (nhyprutil mainkeyboard) next
    case "activekb"
      echo (hyprctl devices -j | jq --raw-output '.keyboards | map(select(.name == "microsoft-wired-keyboard-600")) | map(.active_keymap) | .[0]')
    case "activekbshort"
      echo (nhyprutil activekb | awk '{print $1}' | sed 's/\([A-Z]\)\([a-z]\)[a-z]*/\U\1\2/')
    case "*"
      echo why
  end
end
