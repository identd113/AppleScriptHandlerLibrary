# This script requires stringtolist()

global Shutdown_reason

on run {}
	log "isSystemShutdown(): " & isSystemShutdown()
end run
on isSystemShutdown()
	set Shutdown_reason to "No shutdown attempted"
	set temp to do shell script "log show --last 1m --predicate 'eventMessage contains \"com.apple.system.loginwindow.shutdownInitiated\" or eventMessage contains \"com.apple.system.loginwindow.restartinitiated\" or eventMessage contains \"logoutcancelled\"'"
	set xtemp to my stringtolist("isSystemShutdown", temp, return)
	--if length of xtemp is greater than or equal to 0 then
	repeat with i from length of xtemp to 1 by -1
		if item i of xtemp contains "sendSystemBSDNotification" then
			if item i of xtemp does not contain "noninteractively" then
				
				if item i of xtemp contains "logoutcancelled" then
					set Shutdown_reason to "Shutdown Cancelled"
					return false
				end if
				
				if item i of xtemp contains "restartinitiated" then
					set Shutdown_reason to "Restart"
					return true
				end if
				
				if item i of xtemp contains "shutdownInitiated" then
					set Shutdown_reason to "Shutdown"
					return true
				end if
			end if
		end if
		set Shutdown_reason to "No shutdown attempted"
	end repeat
	return false
end isSystemShutdown

on stringtolist(caller, theString, delim)
	set oldelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delim
	set dlist to (every text item of theString)
	set AppleScript's text item delimiters to oldelim
	return dlist
end stringtolist
