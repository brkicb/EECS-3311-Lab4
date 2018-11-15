note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

create
	make

feature -- Attributes

	empty_string: STRING
	board: ARRAY[STRING]

feature -- Constructor

	make
		do
			-- create 1D array of 9 elements that will be filled
			-- with underscores and this array will represent the
			-- game board
			create board.make_filled("_", 1, 9)
			create empty_string.make_from_string ("_")
		end

feature -- Commands

	play(player: PLAYER position: INTEGER)
		require
			valid_position: is_valid_position(position)
			square_inside_bounds: is_within_bounds(position)
		do
			board[position] := player.get_symbol
		end

	set(s: STRING position: INTEGER)
		require
			valid_position: is_valid_position(position)
			square_inside_bounds: is_within_bounds(position)
		do
			board[position] := s
		end

	set_empty(position: INTEGER)
		require
			square_inside_bounds: is_within_bounds(position)
		do
			board[position] := empty_string
		end

	clear
		do
			create board.make_filled ("_", 1, 9);
		end



feature -- Queries

	get(position: INTEGER): STRING
		require
			square_inside_bounds: is_within_bounds(position)
		do
			Result := board.item (position)
		end

	-- this will return the board as a string that represents a 3 by 3 board
	-- it will be used to properly display the board onto the console
	print_board: STRING
	local
		row: INTEGER;
		column: INTEGER;
		displayedBoard: STRING;
	do
		displayedBoard := ""
		from
			row := 0
		until
			row > 2
		loop
			displayedBoard := displayedBoard + "  "
			from
				column := 0
			until
				column > 2
			loop
				-- display an underscore, X or O in the correct position
				displayedBoard := displayedBoard + board[(row*3)+column+1]
				column := column + 1;
			end
			displayedBoard := displayedBoard + "%N"
			row := row + 1
		end
		Result := displayedBoard
	end

	is_player_win(symbol: STRING): BOOLEAN
		do
			if board[1] ~ symbol and board[2] ~ symbol and board[3] ~ symbol then
				Result := true
			elseif board[4] ~ symbol and board[5] ~ symbol and board[6] ~ symbol then
				Result := true
			elseif board[7] ~ symbol and board[8] ~ symbol and board[9] ~ symbol then
				Result := true
			elseif board[1] ~ symbol and board[4] ~ symbol and board[7] ~ symbol then
				Result := true
			elseif board[2] ~ symbol and board[5] ~ symbol and board[8] ~ symbol then
				Result := true
			elseif board[3] ~ symbol and board[6] ~ symbol and board[9] ~ symbol then
				Result := true
			elseif board[1] ~ symbol and board[5] ~ symbol and board[9] ~ symbol then
				Result := true
			elseif board[3] ~ symbol and board[5] ~ symbol and board[7] ~ symbol then
				Result := true
			else
				Result := false
			end
		end

	is_playerx_win: BOOLEAN
		local
			win_check: BOOLEAN
		do
			win_check := is_player_win("X")
			Result := win_check
		end

	is_playero_win: BOOLEAN
		local
			win_check: BOOLEAN
		do
			win_check := is_player_win("O")
			Result := win_check
		end

	-- 1 is playerx win
	-- 2 is player0 win
	-- 3 is game in progress
	-- 4 is a draw
	game_status: INTEGER
		local
			i: INTEGER
			board_check: BOOLEAN
		do
			if is_player_win ("X") then
				Result := 1
			elseif is_player_win ("O") then
				Result := 2
			else
				board_check := false
				from
					i := 1
				until
				 	i > 9
				loop
				 	if board[i] ~ "_" then
				 		board_check := true
				 	end
				 	i := i + 1
				end
				if board_check then
					Result := 3
				else
					Result := 4
				end
			end
		end

	get_symbol(i: INTEGER): STRING
		do
			Result := board.item (i)
		end

	is_valid_position(square: INTEGER): BOOLEAN
	-- indicates whether a player can go on this square
	do
		Result := board[square] ~ "_";
	end

	is_within_bounds(position: INTEGER): BOOLEAN
		do
			Result := position >= 1 and position <= 9
		end

end
