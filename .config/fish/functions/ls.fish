function ls
	/usr/bin/ls -lh --color=auto $argv
end
function lf
	/usr/bin/ls -fl --color=auto $argv
end
function l
	/home/ilya/.cargo/bin/exa -lGbgaF --icons $argv
end
