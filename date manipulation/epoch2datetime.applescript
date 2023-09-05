#Takes an epich string, IE "1693935606", and returns that time as a date object.
## This requires epoch() handler, included here for runablity 

on run {}
	log my epoch2datetime("1693935606")
end run

on epoch2datetime(epochseconds)
	try
		set unix_time to (characters 1 through 10 of epochseconds) as text
	on error
		set unix_time to epochseconds
	end try
	set epoch_time to my epoch()
	set epochOFFSET to (epoch_time + (unix_time as number) + (time to GMT))
	return epochOFFSET
end epoch2datetime


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