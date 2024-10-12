-- This checks a list of items, against a string, without using a repeat loop.  This does tells you if one of the list items is in the string, but does not tell you the offset.

on itemsInString(caller, listofitems, thestring)
	set handlername to "itemsInString"
	try
		set oldelim to AppleScript's text item delimiters
		set AppleScript's text item delimiters to listofitems
		set dlist to (every text item of thestring)
		set AppleScript's text item delimiters to oldelim
		if length of dlist is greater than 1 then
			return true
		else
			return false
		end if
	on error
		set AppleScript's text item delimiters to oldelim
	end try
end itemsInString

on run {}
	log "Items Matched: " & my itemsInString("test", {1, 2, 3, 4, 5}, "Hello it is 2 Friday!")
	log "No Items Matched: " & my itemsInString("test", {1, 2, 3, 4, 5}, "Hello it is Friday!")
end run