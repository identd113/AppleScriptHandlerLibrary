# Takes a string number ("9"), that is less than 10, and returns it as a 2 digit string

on run {}
	log my padnum("9")
	log my padnum("10")
end run

on padnum(thenum)
	if (length of thenum) is 1 then
		set thenum to ("0" & thenum) as text
	else
		return (thenum) as text
	end if
end padnum