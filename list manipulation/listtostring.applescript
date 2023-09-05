#This handler takes a list, and returns a combined string, with a delimiter added.

on run {}
	set temp1 to {"This", "is", "test", "1"}
	display dialog my listtostring(temp1, " ")
	display dialog my listtostring(temp1, return)
end run

on listtostring(theList, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set alist to theList as text
	set AppleScript's text item delimiters to oldelim
	return alist
end listtostring