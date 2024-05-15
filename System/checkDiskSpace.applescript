# Checks the disk space of a volume, and returns the % full
# Requires stringtolist and emptylist.

on run {}
	set temp_disk to path to startup disk
	set temp_file_posix to POSIX path of temp_disk
	set disk_space to my checkDiskSpace(temp_file_posix)
	log "The disk " & item 1 of disk_space & " is " & item 2 of disk_space & "% full"
	#	choose from list my checkDiskSpace(path to startup disk)
end run

on checkDiskSpace(the_path)
	try
		set checkDiskSpace_return to do shell script "df -h '" & the_path & "'"
		set checkDiskSpace_temp1 to item 2 of my stringtolist(checkDiskSpace_return, return)
		set checkDiskSpace_temp2 to my emptylist(my stringtolist(checkDiskSpace_temp1, space))
		return {the_path, first word of item 5 of checkDiskSpace_temp2 as number}
	on error errmsg
		log errmsg
		return {the_path, 0}
	end try
end checkDiskSpace

on emptylist(klist)
	set nlist to {}
	set dataLength to length of klist
	repeat with i from 1 to dataLength
		if item i of klist is not in {"", {}} then
			set end of nlist to (item i of klist)
		end if
	end repeat
	return nlist
end emptylist

on stringtolist(theString, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set dlist to (every text item of theString)
	set AppleScript's text item delimiters to oldelim
	return dlist
end stringtolist
