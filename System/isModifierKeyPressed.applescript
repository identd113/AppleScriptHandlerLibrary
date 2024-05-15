# This checks to see if any modifier keys are down

on run {}
	delay 1
	set temp_run to my isModifierKeyPressed("")
	log temp_run
	
	if option_down of temp_run = true then
		log "option was down"
	end if
	
	if command_down of temp_run = true then
		log "command was down"
	end if
	
	if control_down of temp_run = true then
		log "control was down"
	end if
	
	if shift_down of temp_run = true then
		log "shift was down"
	end if
	
	if caps_down of temp_run = true then
		log "caps was down"
	end if
	
	if numlock_down of temp_run = true then
		log "numlock was down"
	end if
	
	if function_down of temp_run = true then
		log "function was down"
	end if
	
	if help_down of temp_run = true then
		log "help was down"
	end if
	
end run


on isModifierKeyPressed(checkKey)
	
	set modiferKeysDOWN to {command_down:false, option_down:false, control_down:false, shift_down:false, caps_down:false, numlock_down:false, function_down:false, help_down:false}
	
	if checkKey is in {"", "option", "alt"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagOption)\"") is greater than 1 then
			set option_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "command"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagCommand)\"") is greater than 1 then
			set command_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "shift"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagShift)\"") is greater than 1 then
			set shift_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "control", "ctrl"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagControl)\"") is greater than 1 then
			set control_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "caps", "capslock"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagCapsLock)\"") is greater than 1 then
			set caps_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "numlock"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagNumericPad)\"") is greater than 1 then
			set numlock_down of modiferKeysDOWN to true
		end if
	end if
	
	--Set if any key in the numeric keypad is pressed. The numeric keypad is generally on the right side of the keyboard. This is also set if any of the arrow keys are pressed
	if checkKey is in {"", "function", "func", "fn"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagFunction)\"") is greater than 1 then
			set function_down of modiferKeysDOWN to true
		end if
	end if
	
	if checkKey is in {"", "help", "?"} then
		if (do shell script "osascript -l JavaScript -e \"ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagHelp)\"") is greater than 1 then
			set help_down of modiferKeysDOWN to true
		end if
	end if
	--Set if any function key is pressed. The function keys include the F keys at the top of most keyboards (F1, F2, and so on) and the navigation keys in the center of most keyboards (Help, Forward Delete, Home, End, Page Up, Page Down, and the arrow keys)
	return modiferKeysDOWN
end isModifierKeyPressed