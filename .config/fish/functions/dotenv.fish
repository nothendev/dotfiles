function dotenv
    for line in (cat $argv[1])
        set line (string trim $line)
        # echo line=$line
        if test -z $line
        # Skip comments
        or string match -q "#*" $line
            continue
        end
        set name_value (string split -m 1 = $line)
        set name (string trim $name_value[1])
        set value (string trim $name_value[2])
        # echo name_value=$name_value
        # echo name=$name
        # echo orig_value=$value
        # If the value is quoted, remove the quotes.
        # This is questionable since ' "often" means that the value is a string and should not be interpreted.
        # I'm simply unsure how it should be handled in '.env' files.
        if string match -q '"*"' $value
        or string match -q "'*'" $value
            set value (string sub -s 2 -e -1 $value)
            echo unquoted_value=$value
        end
        # Does the value contain a variable?
        if string match -qr '[$][{][A-Za-z_0-9]*[}]' $value
            set with_variable (string replace -r '[$][{]([A-Za-z_0-9]*)[}]' '$$$1' $value)
            # echo with_variable=$with_variable
            set value (eval "echo $with_variable")
            # If the value is empty, it means that the variable was not set before.
            # We should give a warning in that case.
            if test -z $value
                echo "Warning: unable to set $name since it contains an undefined varible: value=$with_variable"
                continue
            end
            # echo interpreted_value=$value
        end
        echo setting $name to $value
        set -gx $name $value
    end
end
