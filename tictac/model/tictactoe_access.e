note
	description: "Singleton access to the default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	TICTACTOE_ACCESS

feature
	m: TICTACTOE
		once
			create Result.make
		end

invariant
	m = m
end
