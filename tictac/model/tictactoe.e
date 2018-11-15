note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	TICTACTOE

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Attributes

	playerx: PLAYER
	playero: PLAYER
	current_player: PLAYER
	starting_player: PLAYER
	board: BOARD
	status: DISPLAY_STATUS
	current_status: STRING
	current_message: STRING
	game_over_status: BOOLEAN
	operation_list: LINKED_LIST[OPERATION]

feature -- Constructor

	make
		do
			create playerx.make ("", "X")
			create playero.make ("", "O")
			create status.make
			create board.make
			create operation_list.make
			current_player := playerx
			starting_player := playerx
			create current_status.make_from_string (status.ok_status)
			create current_message.make_from_string (status.new_game)
		end

feature -- Commands

	set_current_status (s: STRING)
		do
			current_status := s
		end

	set_current_message (m: STRING)
		do
			current_message := m
		end

	set_current_player (plr: PLAYER)
		do
			current_player := plr
		end

	set_starting_player (plr:PLAYER)
		do
			starting_player := plr
		end

	set_game_over_status (gos: BOOLEAN)
		do
			game_over_status := gos
		end

	set_players (px: STRING po: STRING)
		do
			playerx.set_name (px)
			playerx.set_score (0)
			playero.set_name (po)
			playero.set_score (0)
			current_player := playerx
			starting_player := playerx
		end

feature -- Operations

	new_game (player_x: STRING player_o: STRING)
		local
			new_game_command: NEW_GAME_COMMAND
		do
			create new_game_command.make (Current, player_x, player_o)
			new_game_command.execute
			if new_game_command.error_present then
				if not (operation_list.is_empty or operation_list.islast) then
					from

					until
						operation_list.islast
					loop
						operation_list.remove_right
					end
				end
				operation_list.extend (new_game_command)
				operation_list.finish
			else
				clear_operation_list
				operation_list.extend (new_game_command)
				operation_list.finish
			end
		end

	play (player_name: STRING player_position: INTEGER)
		local
			play_command: PLAY_COMMAND
		do
			create play_command.make (Current, player_name, player_position.as_integer_32)
			play_command.execute
			if play_command.error_present then
				if not (operation_list.is_empty or operation_list.islast) then
					from

					until
						operation_list.islast
					loop
						operation_list.remove_right
					end
				end
				operation_list.extend (play_command)
				operation_list.forth
			else
				if game_over_status then
					clear_operation_list
					operation_list.extend (play_command)
					operation_list.forth
				else
					if not (operation_list.is_empty or operation_list.islast) then
						from

						until
							operation_list.islast
						loop
							operation_list.remove_right
						end
					end
					operation_list.extend (play_command)
					operation_list.forth
				end
			end
		end

	play_again
		local
			play_again_command: PLAY_AGAIN_COMMAND
		do
			create play_again_command.make (Current)
			play_again_command.execute
			if play_again_command.error_present then
				if not (operation_list.is_empty or operation_list.islast) then
					from

					until
						operation_list.islast
					loop
						operation_list.remove_right
					end
				end
				operation_list.extend (play_again_command)
				operation_list.forth
			else
				clear_operation_list
				operation_list.extend (play_again_command)
				operation_list.forth
			end
		end

	undo
		local
			operation: OPERATION
		do
			if operation_list.before then
				-- don't do anything
			elseif attached {NEW_GAME_COMMAND} operation_list.first and operation_list.isfirst then
				set_current_status (status.ok_status)
			elseif attached {PLAY_AGAIN_COMMAND} operation_list.first and operation_list.isfirst then
				-- don't do anything
			elseif not (operation_list.before and operation_list.isfirst) then
				if attached {NEW_GAME_COMMAND} operation_list.first and operation_list.first.error_present then
					clear_operation_list
					set_current_status (status.ok_status)
					set_current_message (status.get_new_game)
				else
					operation := operation_list.item
					operation.undo
					operation_list.back
				end
			elseif operation_list.isfirst then
				set_current_status (status.ok_status)
				set_current_message (status.get_new_game)
			end
		end

	redo
		local
			operation: OPERATION
		do
			if operation_list.before then
				-- don't do anything
			elseif not (operation_list.before or operation_list.islast) then
				operation_list.forth
				operation := operation_list.item
				operation.redo
			end
		end

	clear_operation_list
		local
			op_list: LINKED_LIST[OPERATION]
		do
			create op_list.make
			operation_list := op_list
		end

feature -- Queries

	game_status: INTEGER
		do
			Result := board.game_status
		end

	is_game_over: BOOLEAN
		do
			Result := game_over_status
		end

feature -- model operations

	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := "  " + current_status + ":"
			if current_message ~ status.get_new_game then
				Result := Result + " "
			end
			Result := Result + " => " + current_message + "%N"
			Result := Result + board.print_board
			Result := Result + "  " + playerx.get_score.out + ": score for %"" + playerx.get_name + "%" (as " + playerx.get_symbol + ")%N"
			Result := Result + "  " + playero.get_score.out + ": score for %"" + playero.get_name + "%" (as " + playero.get_symbol + ")"
		end

end -- class TICTACTOE

