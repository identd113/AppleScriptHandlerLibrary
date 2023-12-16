#This takes a day of the week, as a string, and "next" or "last".  The returned data is a date object, with the next or last day of the week
on dayofweek(the_day, next_or_last)
	set valid_days to {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
	if the_day is in valid_days then
		set cd to current date
		if next_or_last is "next" then
			set tempcd to 7
			set whichby to 1
		end if
		if next_or_last is "last" then
			set tempcd to -7
			set whichby to -1
		end if
		repeat with i from 0 to tempcd by whichby
			set temp_time to ((cd) + (i * days))
			if (weekday of temp_time) as text is the_day and temp_time is not (cd) then
				return date (date string of temp_time)
			end if
		end repeat
	else
		return false
	end if
end dayofweek

on run {}
	log my dayofweek("Friday", "next")
end run
