function moth
	set result (math $argv[1])
	set title ($argv[1]) + ' ='
	notify-send $title $result
end
