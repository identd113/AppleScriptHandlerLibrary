#This handler takes a string, and returns a list, based on the specified delimiter 

on run {}
	set temp1 to "This is test 1"
	choose from list my stringtolist(temp1, " ")
end run

on stringtolist(theString, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set dlist to (every text item of theString)
	set AppleScript's text item delimiters to oldelim
	return dlist
end stringtolist