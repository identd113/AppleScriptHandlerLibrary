
on run {}
	set coin_result to my flipCoin("1")
	log coin_result
end run

on flipCoin(flipCount)
	set headsUp to 0
	set tailsUp to 0
	set coinSide to {"Heads", "Tails"}
	
	repeat with i from 1 to flipCount
		set temp_result to some item of coinSide
		if temp_result is "Heads" then
			set headsUp to headsUp + 1
		end if
		if temp_result is "Tails" then
			set tailsUp to tailsUp + 1
		end if
	end repeat
	return {heads:headsUp, tails:tailsUp}
end flipCoin


