set -U fish_greeting
# bash -c "eval \$\(ssh-agent\)" // slow
starship init fish | source
starship completions fish | source
set -gx EDITOR nvim
#if test -d (brew --prefix)"/share/fish/completions"
#    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
#end
ssh-add ~/key/rpimedia &> /dev/null
#if test -d (brew --prefix)"/share/fish/vendor_completions.d"
#    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
#end
alias nd goneovim
alias discorr "/usr/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias operra "/usr/bin/opera --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias wwmenu "/usr/bin/dmenu_path | /usr/bin/wmenu | /usr/bin/xargs swaymsg exec --"
#set -gx PATH "/mnt/u/js/emsdk/upstream/emscripten" $PATH
set -gx PATH "/home/ilya/.cargo/bin" $PATH
set -gx PATH "/home/ilya/.local/share/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "/home/ilya/.konan/kotlin-native-prebuilt-linux-x86_64-1.8.0" $PATH
# set -gx EMSDK_QUIET 1
# source "/mnt/u/js/emsdk/emsdk_env.fish"
# pnpm
set -gx PNPM_HOME "/home/ilya/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx PATH "/home/ilya/.local/bin" $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx DENO_INSTALL "/home/ilya/.deno"
set -gx PATH $DENO_INSTALL/bin $PATH

ls > /dev/null

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/ilya/.ghcup/bin # ghcup-env
