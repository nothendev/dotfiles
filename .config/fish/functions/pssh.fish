function pssh -a pi
	switch $argv[1]
		case 'pi'
			command kitty +kitten ssh pi@192.168.31.16
			return
    case 'matest'
      command kitty +kitten ssh root@83.222.2.171
      return
		case ''
			echo empty hostname/alias!
			echo aliases: [ pi ]
			return
		case '*'
			command kitty +kitten ssh $argv[1]
			return
	end
end
