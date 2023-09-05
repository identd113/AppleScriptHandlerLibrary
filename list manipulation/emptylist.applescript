# Takes a list, that may contain "", or {} in the list, and removes them.

on run {}
	set temp to {"Hello", "my", "name", "", {}, "is", "Mike"}
	log temp
	log my emptylist(temp)
end run

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