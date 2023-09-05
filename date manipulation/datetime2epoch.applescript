# This takes a date object, and returns that in epoch
# Requires epoch(), and getTfromN() which is included to make this runnable.

on run {}
	set temp to ((current date) - 732 * days)
	log my datetime2epoch(temp)
end run

on datetime2epoch(the_date_object)
	--log "datetime2epoch: " & caller & " " & the_date_object
	return my getTfromN(the_date_object - (my epoch()))
end datetime2epoch


on epoch()
	set epoch_time to current date
	set day of epoch_time to 1 --added to work around month rolling issue (31/30)
	set hours of epoch_time to 0
	set minutes of epoch_time to 0
	set seconds of epoch_time to 0
	set year of epoch_time to "1970"
	set month of epoch_time to "1"
	set day of epoch_time to "1"
	return epoch_time
end epoch

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