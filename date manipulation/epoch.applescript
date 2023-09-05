# Returns the beginning of the unix epoch, as a date object

on run {}
	log my epoch()
end run


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