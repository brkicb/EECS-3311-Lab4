note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature -- Attributes
	name: STRING
	symbol: STRING
	score: INTEGER

feature -- Constructor
	make(n: STRING sym: STRING)
		do
			set_name(n)
			set_symbol(sym)
			set_score(0)
		end
feature -- Queries
	get_name : STRING
		do
			Result := name
		end

	get_symbol : STRING
		do
			Result := symbol
		end

	get_score : INTEGER
		do
			Result := score
		end

feature -- Commands
	increase_score
		do
			score := score + 1
		end

	set_name(player_name: STRING)
		do
			name := player_name
		end

	set_symbol(s: STRING)
		do
			symbol := s
		end

	set_score(scr: INTEGER)
		do
			score := scr
		end

end
