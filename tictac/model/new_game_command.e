note
	description: "Summary description for {NEW_GAME_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_GAME_COMMAND

inherit
	OPERATION

create
	make

feature -- Attributes

	current_game: TICTACTOE
	player_x_name: STRING
	player_o_name: STRING
	old_status: STRING
	old_message: STRING

feature -- Constructor

	make (cur_game: TICTACTOE px_name: STRING po_name: STRING)
		do
			current_game := cur_game
			player_x_name := px_name
			player_o_name := po_name
			old_status := current_game.current_status
			old_message := current_game.current_message
			error_present := false
		end

feature -- Commands

	execute
		do
			if player_x_name ~ player_o_name then
				error_present := true
				current_game.set_current_status (current_game.status.different_names)
			elseif player_x_name.is_empty or player_o_name.is_empty or not (('a' <= player_x_name.at (1) and player_x_name.at (1) <= 'z') or ('A' <= player_x_name.at (1) and player_x_name.at (1) <= 'Z')) or not (('a' <= player_o_name.at (1) and player_o_name.at (1) <= 'z') or ('A' <= player_o_name.at (1) and player_o_name.at (1) <= 'Z')) then
				error_present := true
				current_game.set_current_status (current_game.status.start_of_name)
			else
				error_present := false
				current_game.clear_operation_list
				current_game.set_game_over_status (false)
				current_game.set_current_status (current_game.status.ok_status)
				current_game.board.clear
				current_game.set_players (player_x_name, player_o_name)
				current_game.set_current_message (current_game.status.next (current_game.current_player.get_name))
			end
		end

	undo
		do
			if error_present then
				current_game.set_current_status (old_status)
				current_game.set_current_message (old_message)
			end
		end

	redo
		do
			execute
		end

end
