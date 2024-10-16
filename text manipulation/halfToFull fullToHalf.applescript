-- Global variables to store half-width and full-width character lists
global Half_width_list
global Full_width_list

on run
	-- Initialize Half_width_list with ASCII characters (half-width) for A-Z, a-z, and 0-9
	set Half_width_list to {ASCII character 65, ASCII character 66, ASCII character 67, ASCII character 68, ASCII character 69, ASCII character 70, ASCII character 71, ASCII character 72, ASCII character 73, ASCII character 74, ASCII character 75, ASCII character 76, ASCII character 77, ASCII character 78, ASCII character 79, ASCII character 80, ASCII character 81, ASCII character 82, ASCII character 83, ASCII character 84, ASCII character 85, ASCII character 86, ASCII character 87, ASCII character 88, ASCII character 89, ASCII character 90, ASCII character 97, ASCII character 98, ASCII character 99, ASCII character 100, ASCII character 101, ASCII character 102, ASCII character 103, ASCII character 104, ASCII character 105, ASCII character 106, ASCII character 107, ASCII character 108, ASCII character 109, ASCII character 110, ASCII character 111, ASCII character 112, ASCII character 113, ASCII character 114, ASCII character 115, ASCII character 116, ASCII character 117, ASCII character 118, ASCII character 119, ASCII character 120, ASCII character 121, ASCII character 122, ASCII character 48, ASCII character 49, ASCII character 50, ASCII character 51, ASCII character 52, ASCII character 53, ASCII character 54, ASCII character 55, ASCII character 56, ASCII character 57}
	
	-- Initialize Full_width_list with full-width characters for A-Z, a-z, and 0-9
	set Full_width_list to {"Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ", "Ｐ", "Ｑ", "Ｒ", "Ｓ", "Ｔ", "Ｕ", "Ｖ", "Ｗ", "Ｘ", "Ｙ", "Ｚ", "ａ", "ｂ", "ｃ", "ｄ", "ｅ", "ｆ", "ｇ", "ｈ", "ｉ", "ｊ", "ｋ", "ｌ", "ｍ", "ｎ", "ｏ", "ｐ", "ｑ", "ｒ", "ｓ", "ｔ", "ｕ", "ｖ", "ｗ", "ｘ", "ｙ", "ｚ", "０", "１", "２", "３", "４", "５", "６", "７", "８", "９"}
	
	-- Convert half-width character "a" to its full-width equivalent and log the result
	log my halfToFull("a")
	
	-- Convert full-width character "ａ" to its half-width equivalent and log the result
	log my fullTohalf("ａ")
end run

-- Function to convert half-width character to full-width equivalent
on halfToFull(char)
	-- Iterate through the Half_width_list to find the match
	repeat with i from 1 to length of Half_width_list
		considering case -- Ensure case-sensitive comparison
			if char is item i of Half_width_list then
				-- Return the corresponding full-width character
				return item i of Full_width_list
			end if
		end considering
	end repeat
end halfToFull

-- Function to convert full-width character to half-width equivalent
on fullTohalf(char)
	-- Iterate through the Full_width_list to find the match
	repeat with i from 1 to length of Full_width_list
		considering case -- Ensure case-sensitive comparison
			if char is item i of Full_width_list then
				-- Return the corresponding half-width character
				return item i of Half_width_list
			end if
		end considering
	end repeat
end fullTohalf
