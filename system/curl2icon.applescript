--This takes a image URL, downloads it to the local machine, and returns the local file path.  This can then be used to display a custom image in a display dialog 

on run {}
	set icon_path to my curl2icon("https://www.apple.com/newsroom/images/logos/quick-reads-logos/Apple-App-Store.jpg.square_social.jpg")
	display dialog "Hello World!" with icon icon_path
end run

on curl2icon(thelink)
	try
		set savename to last item of my stringtolist(thelink, "/")
	on error errmsg
		return caution
	end try
	try
		set temp_path to POSIX path of (path to home folder) & "Library/Caches/hdhr_VCR/" & savename as text
		if my checkfileexists(temp_path) is true then
			try
				do shell script "touch " & temp_path
			on error errmsg
			end try
		else
			do shell script "curl --silent -H 'appname:" & name of me & "' '" & thelink & "' -o '" & temp_path & "'"
		end if
		return POSIX file temp_path
	on error errmsg
		return caution
	end try
end curl2icon

on stringtolist(theString, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set dlist to (every text item of theString)
	set AppleScript's text item delimiters to oldelim
	return dlist
end stringtolist

on checkfileexists(filepath)
	try
		--if class of filepath is not «class furl» then
		if class of filepath is not alias then
			set filepath to POSIX file filepath
		end if
		tell application "Finder" to return (exists filepath)
	on error errmsg
		return false
	end try
end checkfileexists