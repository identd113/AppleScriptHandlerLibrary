# Takes a number like "1.8008675309E+10" and makes it a string number

on run {}
	log my getTfromN(1.8008675309E+10)
end run


on getTfromN(this_number)
	set this_number to this_number as text
	if this_number contains "E+" then
		set x to the offset of "." in this_number
		set y to the offset of "+" in this_number
		set z to the offset of "E" in this_number
		set the decimal_adjust to characters (y - (length of this_number)) thru -1 of this_number as text as number
		if x is not 0 then
			set the first_part to characters 1 thru (x - 1) of this_number as text
		else
			set the first_part to ""
		end if
		set the second_part to characters (x + 1) thru (z - 1) of this_number as text
		set the converted_number to the first_part
		repeat with i from 1 to the decimal_adjust
			try
				set the converted_number to the converted_number & character i of the second_part
			on error
				set the converted_number to the converted_number & "0"
			end try
		end repeat
		return the converted_number
	else
		return this_number
	end if
end getTfromN