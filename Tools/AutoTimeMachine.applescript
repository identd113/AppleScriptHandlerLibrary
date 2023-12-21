
on run {}
	set progress description to "Starting " & name of me
	delay 1
	set destid to my getBackupID()
	set progress completed steps to 0
	set progress total steps to 1
	set progress description to "Verifying " & quote & item 2 of destid & quote & " is mounted..."
	set mountDriveResponse to my mountDrive(item 2 of destid)
	delay 1
	set progress additional description to mountDriveResponse
	set progress completed steps to 1
	delay 1
	set progress total steps to -1
	set progress completed steps to -1
	set progress description to "Starting Backup..."
	set progress additional description to "Backup Destination ID: " & item 1 of destid & return & "Backup Destination Name: " & item 2 of destid
	delay 1
	set runBackupResponse to my runBackup(item 1 of destid)
	set progress total steps to 1
	set progress completed steps to 1
	delay 1
	set progress completed steps to 0
	set progress total steps to 1
	set progress additional description to runBackupResponse
	set progress description to "Backup Complete, ejecting disk..."
	delay 1
	my ejectDrive(item 2 of destid)
	set progress completed steps to 1
	set progress description to "Backup Complete, and disk ejected."
	delay 10
end run

on runBackup(dest_id)
	set runBackup_temp to (do shell script "tmutil startbackup --block --destination " & dest_id)
end runBackup

on getBackupID()
	set theID to ""
	set theNAME to ""
	set getBackupID_temp to (do shell script "tmutil destinationinfo")
	set getBackupID_list to my stringtolist(getBackupID_temp, return)
	repeat with i from 1 to length of getBackupID_list
		if item i of getBackupID_list starts with "ID" then
			set theID to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			log theID
		end if
		
		if item i of getBackupID_list starts with "Name" then
			set theNAME to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			log theNAME
		end if
	end repeat
	return {theID, theNAME}
end getBackupID

on mountDrive(diskname)
	do shell script "diskutil mount " & diskname
end mountDrive

on ejectDrive(diskname)
	do shell script "diskutil eject " & diskname
end ejectDrive


on stringtolist(theString, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set dlist to (every text item of theString)
	set AppleScript's text item delimiters to oldelim
	return dlist
end stringtolist

on listtostring(theList, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set alist to theList as text
	set AppleScript's text item delimiters to oldelim
	return alist
end listtostring

