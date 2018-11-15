note
	description: "Summary description for {PLAY_AGAIN_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAY_AGAIN_COMMAND

inherit
	OPERATION

create
	make

feature -- Atrributes

	current_game: TICTACTOE
	old_status: STRING
	old_message: STRING

feature -- Constructor
	make (cur_game: TICTACTOE)
		do
			current_game := cur_game
			old_status := current_game.current_status
			old_message := current_game.current_message
			error_present := false
		end

feature -- Commands
	execute
		do
			if current_game.game_over_status then
				error_present := false
				current_game.set_game_over_status (false)
				current_game.board.clear
				current_game.clear_operation_list
				if current_game.starting_player.get_symbol ~ "X" then
					current_game.set_current_player (current_game.playero)
					current_game.set_starting_player (current_game.playero)
					current_game.set_current_status (current_game.status.ok_status)
					current_game.set_current_message (current_game.status.next (current_game.current_player.name))
				else
					current_game.set_current_player (current_game.playerx)
					current_game.set_starting_player (current_game.playerx)
					current_game.set_current_status (current_game.status.ok_status)
					current_game.set_current_message (current_game.status.next (current_game.current_player.name))
				end
			else
				error_present := true
				current_game.set_current_status (current_game.status.finish)
			end
		end

	undo
		do
			if error_present then
				current_game.set_current_status (old_status)
				current_game.set_current_message (old_message)
			else

			end
		end

	redo
		do
			execute
		end

end
