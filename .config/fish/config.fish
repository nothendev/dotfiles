set -U fish_greeting
# bash -c "eval \$\(ssh-agent\)" // slow
starship init fish | source
starship completions fish | source
any-nix-shell fish --info-right | source
set -q JAVA_HOME; or set JAVA_HOME ''; set -gx JAVA_HOME "/usr/lib/jvm/zulu17/"
set -gx EDITOR nvim
set -gx GLORYX_USERNAME 'nothen'; set -gx GLORYX_PASSWORD 'ThingsGood:5'
#if test -d (brew --prefix)"/share/fish/completions"
#    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
#end

#if test -d (brew --prefix)"/share/fish/vendor_completions.d"
#    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
#end

#set -gx PATH "/mnt/u/js/emsdk/upstream/emscripten" $PATH
set -gx PATH "/home/ilya/.cargo/bin" $PATH
set -gx PATH "/home/ilya/.local/share/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "/home/ilya/.konan/kotlin-native-prebuilt-linux-x86_64-1.8.0" $PATH
# set -gx EMSDK_QUIET 1
# source "/mnt/u/js/emsdk/emsdk_env.fish"
# pnpm
set -gx PNPM_HOME "/home/ilya/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

set -gx PATH "/home/ilya/.local/bin" $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx DENO_INSTALL "/home/ilya/.deno"
set -gx PATH $DENO_INSTALL/bin $PATH

ls > /dev/null
