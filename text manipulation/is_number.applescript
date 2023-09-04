
# This tells us if the number_string can be a number, returns true/false
on run {}
	log "is_number(A): " & my is_number("A")
	log "is_number(42): " & my is_number("42")
end run

on is_number(number_string)
	try
		set number_string to number_string as number
		return true
	on error
		return false
	end try
end is_number