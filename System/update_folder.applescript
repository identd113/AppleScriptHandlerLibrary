# This will take a filesystem path, and verify we can write to it, then deletes it

on run {}
	log "Folder Updated: " & my update_folder(path to home folder)
end run

on update_folder(update_path)
	set posix_update_path to POSIX path of update_path
	try
		do shell script "touch \"" & posix_update_path & ".test_write\""
		delay 0.1
		do shell script "rm \"" & posix_update_path & ".test_write\""
		return true
	on error errmsg
		return false
	end try
end update_folder

