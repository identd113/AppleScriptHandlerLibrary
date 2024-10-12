--This does a strikethrough of text.  This returns both the original test as item 1, and the strikethrough test, which is item 2.  822 looks the best

on encode_strikethrough(thedata, decimel_char)
	set handlername to "encode_strikethrough"
	set encoded_line to {}
	repeat with i from 1 to length of thedata
		set end of encoded_line to (item i of thedata & character id decimel_char)
	end repeat
	return {thedata, encoded_line as text}
end encode_strikethrough

on run {}
	set final_list to {}
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 768) -- Combining Grave Accent (Decimal: 768)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 769) -- Combining Acute Accent (Decimal: 769)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 770) -- Combining Circumflex Accent (Decimal: 770)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 771) -- Combining Tilde (above) (Decimal: 771)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 772) -- Combining Macron (Decimal: 772)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 773) -- Combining Overline (Decimal: 773)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 774) -- Combining Breve (Decimal: 774)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 775) -- Combining Dot Above (Decimal: 775)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 776) -- Combining Diaeresis (Decimal: 776)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 777) -- Combining Hook Above (Decimal: 777)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 795) -- Combining Horn (Decimal: 795)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 803) -- Combining Dot Below (Decimal: 803)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 804) -- Combining Diaeresis Below (Decimal: 804)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 805) -- Combining Ring Below (Decimal: 805)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 807) -- Combining Cedilla (Decimal: 807)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 808) -- Combining Ogonek (Decimal: 808)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 814) -- Combining Breve Below (Decimal: 814)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 816) -- Combining Tilde Below (Decimal: 816)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 820) -- Combining Tilde Overlay (Decimal: 820)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 821) -- Combining Short Stroke Overlay (Decimal: 821)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 822) -- Combining Long Stroke Overlay (Decimal: 822)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 823) -- Combining Short Solidus Overlay (Decimal: 823)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 824) -- Combining Long Solidus Overlay (Decimal: 824)
	set end of final_list to item 2 of my encode_strikethrough("This is the test we want strikethrough!", 8402) -- Combining Long Vertical Line Overlay (Decimal: 8402)
	
	
	choose from list final_list
end run