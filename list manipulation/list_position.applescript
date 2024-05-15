# This returns of offset of a string in a list

on run {}
	set temp_list to {"Eggplant", "Bread", "Milk", "Water", "egg"}
	log "#1 " & my list_position("Egg", temp_list, false) -- This returns 1, as is_strict is set to false
	log "#2 " & my list_position("Egg", temp_list, true) -- This returns 5, as is_strict is set to true
	
end run


on list_position(this_item, this_list, is_strict)
	if this_item is not false then
		repeat with i from 1 to length of this_list
			if is_strict is false then
				if (item i of this_list as text) contains (this_item as text) then
					return i
				end if
			else
				if (item i of this_list as text) is (this_item as text) then
					--display dialog "list_post2: " & i
					return i
				end if
			end if
		end repeat
	end if
	return 0
end list_position