global app_version
global app_string
global Destination_Info
global Selected_Backup
global Backup_status
global Backup_started

use AppleScript version "2.4"
use scripting additions
use application "JSON Helper"

on run {}
	set Destination_Info to {}
	set Selected_Backup to 0
	set app_version to "20240120"
	set Backup_started to false
	set app_string to name of me & " " & app_version
	set progress description to "Starting " & app_string
	--my statusBackup()
	my main()
end run

on main()
	delay 1
	set Destination_Info to my getBackupID()
	set item 1 of Destination_Info to ""
	set Destination_Info to my emptylist(Destination_Info)
	
	if length of Destination_Info is greater than or equal to 2 then
		set selectedResponse to my selectBackup("")
	else
		set Selected_Backup to 1
	end if
	if Selected_Backup is not 0 then
		set progress completed steps to 0
		log "1"
		set progress total steps to 1
		set progress description to ("Verifying " & atm_name of item Selected_Backup of Destination_Info & " is mounted..." as string)
		log "2"
		log "Verifying " & atm_name of item Selected_Backup of Destination_Info & " is mounted..." as string
		log "3"
		delay 0.1
		set mountDriveResponse to my mountDrive(Selected_Backup)
		delay 0.1
		set progress additional description to mountDriveResponse
		set progress completed steps to 1
		delay 1
		set progress total steps to -1
		set progress completed steps to -1
		activate me
		set progress description to "Starting Backup with " & app_string
		set progress additional description to "Backup Destination ID: " & atm_id of item Selected_Backup of Destination_Info & return & "Backup Destination Name: " & atm_name of item Selected_Backup of Destination_Info
		delay 0.1
		set runBackupResponse to my runBackup(Selected_Backup)
	end if
end main

on reopen {}
	activate me
end reopen

on idle {}
	my parse_status() 
	if tm_running of Backup_status is 1 then
		set progress total steps to 1
		set Backup_started to true
		set progress description to tm_BackupPhase of Backup_status
		set progress completed steps to tm_Percent of Backup_status
	end if
	
	if Backup_started is true and tm_running of Backup_status is 0 then
		delay 1
		set progress completed steps to 0
		set progress total steps to 1
		set progress additional description to runBackupResponse
		activate me
		set progress description to "Backup Complete, ejecting disk...(" & app_string & ")"
		delay 0.1
		my ejectDrive(Selected_Backup)
		delay 1
		set progress completed steps to 1
		set progress description to "Backup Complete, and disk ejected. (" & app_string & ")"
		delay 10
		quit {}
	end if
	beep
	return 3
end idle

on runBackup(the_offset)
	--display dialog "tmutil startbackup --block --destination " & dest_id
	--do shell script "tmutil startbackup --block --destination " & atm_id of item the_offset of Destination_Info)
	--	do shell script "tmutil startbackup --destination " & atm_id of item the_offset of Destination_Info
	delay 2
	my parse_status()
	return (do shell script "tmutil startbackup --destination " & atm_id of item the_offset of Destination_Info)
end runBackup

on getBackupID()
	set theID to ""
	set theNAME to ""
	set theURL to ""
	set getBackupID_temp to (do shell script "tmutil destinationinfo")
	set getBackupID_list to my stringtolist(getBackupID_temp, return)
	set returned_backups to {}
	set new_item_reset to true
	
	repeat with i from 1 to length of getBackupID_list
		if new_item_reset is true then
			set newBackup to {atm_name:"", atm_kind:"", atm_url:"", atm_id:"", atm_quota:""}
			set new_item_reset to false
		end if
		
		--	try
		if item i of getBackupID_list starts with "Name" then
			set atm_name of newBackup to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			--	log atm_name of newBackup
		end if
		--	end try
		
		--	try
		if item i of getBackupID_list starts with "Kind" then
			set atm_kind of newBackup to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			--	log "kind: " & atm_kind of newBackup
		end if
		--	end try
		
		--	try
		if item i of getBackupID_list starts with "ID" then
			set atm_id of newBackup to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			--	log "id: " & atm_id of newBackup
		end if
		--	end try
		
		--	try
		if item i of getBackupID_list starts with "URL" then
			set atm_url of newBackup to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			--	log "url: " & atm_url of newBackup
		end if
		--	end try
		if item i of getBackupID_list starts with "Quota" then
			set atm_quota of newBackup to item 2 of my stringtolist(item i of getBackupID_list, ": ")
			--	log "quota: " & atm_quota of newBackup
		end if
		if item i of getBackupID_list contains "=" or i is length of getBackupID_list then
			--	log "yes"
			set new_item_reset to true
			--	log newBackup
			set end of returned_backups to newBackup
		end if
		
	end repeat
	return returned_backups
end getBackupID

on parse_status()
	set Backup_running to {tm_BackupPhase:"", tm_ClientID:"", tm_DestinationID:"", tm_DestinationMountPoint:"", tm_FractionOfProgressBar:"", tm_Percent:"", tm_bytes:"", tm_totalBytes:"", totalFiles:"", tm_running:0, tm_TimeRemaining:""}
	set status_response to do shell script "tmutil status"
	set status_response to my removeChars(status_response, {quote, ";"})
	set status_response_parsed to my stringtolist(status_response, return)
	set item 1 of status_response_parsed to ""
	set status_response_parsed to my emptylist(status_response_parsed)
	--	choose from list status_response_parsed
	log length of status_response_parsed
	repeat with i from 1 to length of status_response_parsed
		--log item i of status_response_parsed
		
		try
			if item i of status_response_parsed contains "Percent" then
				set tm_Percent of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_Percent of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "ClientID" then
				set tm_ClientID of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_ClientID of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		
		try
			if item i of status_response_parsed contains "Running" then
				set tm_running of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_running of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "BackupPhase" then
				set tm_BackupPhase of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_BackupPhase of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "DestinationID" then
				set tm_DestinationID of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_DestinationID of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "DestinationMountPoint" then
				set tm_DestinationMountPoint of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_DestinationMountPoint of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "TimeRemaining" then
				set tm_TimeRemaining of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_TimeRemaining of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
		try
			if item i of status_response_parsed contains "bytes" then
				set tm_bytes of Backup_running to item 2 of my stringtolist(item i of status_response_parsed, {" = "})
				log tm_bytes of Backup_running
			end if
		on error errmsg
			display dialog errmsg
		end try
		
	end repeat
	
	set Backup_status to Backup_running
	
end parse_status

on mountDrive(the_offset)
	if atm_kind of item Selected_Backup of Destination_Info is "Local" then
		return (do shell script "diskutil mount " & quote & atm_name of item the_offset of Destination_Info & quote)
	else if atm_kind of item Selected_Backup of Destination_Info is "Network" then
		return (do shell script "open " & quote & atm_url of item the_offset of Destination_Info & quote)
	end if
end mountDrive

on ejectDrive(the_offset)
	if atm_kind of item Selected_Backup of Destination_Info is "Local" then
		return (do shell script "diskutil eject " & quote & atm_name of item the_offset of Destination_Info & quote)
	else if atm_kind of item the_offset of Destination_Info is "Network" then
		return (do shell script "umount " & quote & "/Volumes/" & atm_name of item the_offset of Destination_Info & quote)
	end if
end ejectDrive

on selectBackup(the_offset)
	set disk_names to {}
	set temp_names to my getNames(0)
	try
		set backup_run_offset to (choose from list temp_names)
	end try
	set Selected_Backup to my list_position(backup_run_offset, temp_names, true)
	log Selected_Backup
	return Selected_Backup
end selectBackup

on getNames(the_offset)
	set disk_name to {}
	repeat with i from 1 to length of Destination_Info
		set end of disk_name to atm_name of item i of Destination_Info
	end repeat
	log disk_name
	if the_offset is 0 then
		return disk_name
	else
		return item the_offset of disk_name
	end if
end getNames

on getIDs(the_offset)
	set disk_id to {}
	repeat with i from 1 to length of Destination_Info
		set end of disk_id to atm_type of item i of Destination_Info
	end repeat
	log disk_id
	if the_offset is 0 then
		return disk_id
	else
		return item the_offset of disk_id
	end if
end getIDs

on getTypes(the_offset)
	set disk_type to {}
	repeat with i from 1 to length of Destination_Info
		set end of disk_type to atm_type of item i of Destination_Info
	end repeat
	log disk_type
	if the_offset is 0 then
		return disk_type
	else
		return item the_offset of disk_type
	end if
end getTypes

on getQuotas(the_offset)
	set disk_quota to {}
	repeat with i from 1 to length of Destination_Info
		set end of disk_quota to atm_quota of item i of Destination_Info
	end repeat
	log disk_quota
	if the_offset is 0 then
		return disk_quota
	else
		return item the_offset of disk_quota
	end if
end getQuotas

on getUrls(the_offset)
	set disk_url to {}
	repeat with i from 1 to length of Destination_Info
		set end of disk_url to atm_url of item i of Destination_Info
	end repeat
	log disk_url
	if the_offset is 0 then
		return disk_url
	else
		return item the_offset of disk_url
	end if
end getUrls

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

on list_position(this_item, this_list, is_strict)
	if this_item is not false then
		repeat with i from 1 to length of this_list
			if is_strict is false then
				if (item i of this_list as text) contains (this_item as text) then
					return i
				end if
			else
				if (item i of this_list as text) is (this_item as text) then
					return i
				end if
			end if
		end repeat
	end if
	return 0
end list_position

on removeChars(theString, toremove)
	set oldelim to AppleScript's text item delimiters
	try
		set AppleScript's text item delimiters to toremove
		set dlist to (every text item of theString)
		set AppleScript's text item delimiters to oldelim
		set final_txt to dlist as text
		return final_txt
	on error errmsg
		set AppleScript's text item delimiters to oldelim
		display dialog errmsg
	end try
end removeChars

