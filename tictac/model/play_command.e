note
	description: "Summary description for {PLAY_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAY_COMMAND

inherit
	OPERATION

create
	make

feature -- Atrributes
	player_name: STRING
	player_position: INTEGER
	current_game: TICTACTOE
	old_status: STRING
	old_message: STRING
	old_score_playerx: INTEGER
	old_score_playero: INTEGER
	is_valid_check: BOOLEAN

feature -- Contructor
	make(cur_game: TICTACTOE plr_name: STRING plr_position: INTEGER)
		do
			current_game := cur_game
			player_name := plr_name
			player_position := plr_position.as_integer_32
			error_present := false
			old_status := current_game.current_status
			old_message := current_game.current_message
		end

feature

	execute
		local
			i: INTEGER
		do
			old_status := current_game.current_status
			old_message := current_game.current_message

			if is_valid then
				is_valid_check := true
				error_present := false
				current_game.board.play (current_game.current_player, player_position)
				i := current_game.game_status
				-- i ~ 1 = playerx won, i ~ 2 = playero won, i ~ 3 = game in progress, i ~ 4 = draw
				if i ~ 1 then
					current_game.set_game_over_status (true)
					old_score_playerx := current_game.playerx.get_score
					old_score_playero := current_game.playero.get_score
					current_game.playerx.increase_score
					current_game.set_current_status (current_game.status.get_winner)
					current_game.set_current_message (current_game.status.get_play_again_new_game)
					current_game.clear_operation_list
				elseif i ~ 2 then
					current_game.set_game_over_status (true)
					old_score_playerx := current_game.playerx.get_score
					old_score_playero := current_game.playero.get_score
					current_game.playero.increase_score
					current_game.set_current_status (current_game.status.get_winner)
					current_game.set_current_message (current_game.status.get_play_again_new_game)
					current_game.clear_operation_list
				elseif i ~ 4 then
					current_game.set_game_over_status (true)
					current_game.set_current_status (current_game.status.get_tie_game)
					current_game.set_current_message (current_game.status.get_play_again_new_game)
					current_game.clear_operation_list
				elseif i ~ 3 then
					current_game.set_game_over_status (false)
					if current_game.current_player = current_game.playerx then
						current_game.set_current_player (current_game.playero)
					else
						current_game.set_current_player (current_game.playerx)
					end
					current_game.set_current_status (current_game.status.ok_status)
					current_game.set_current_message (current_game.status.next (current_game.current_player.name))
				end
			else
				is_valid_check := false
				error_present := true
				if current_game.is_game_over then
					if current_game.game_status ~ 1 or current_game.game_status ~ 2 then
						current_game.set_current_status (current_game.status.get_winner)
					else
						current_game.set_current_status (current_game.status.get_game_finished)
					end
				elseif player_name ~ "" or (player_name /~ current_game.playero.name and player_name /~ current_game.playerx.name) then
					current_game.set_current_status (current_game.status.get_player_not_exist)
				elseif player_name /~ current_game.current_player.name then
					current_game.set_current_status (current_game.status.not_player_turn)
				elseif current_game.board.get (player_position) /~ current_game.board.empty_string then
					current_game.set_current_status (current_game.status.button_taken)
				end
			end
		end

	undo
		do
			if error_present then
				current_game.set_current_status (old_status)
				current_game.set_current_message (old_message)
			else
				if not current_game.is_game_over then
					current_game.board.set_empty (player_position)
					current_game.set_current_status (old_status)
					current_game.set_current_message (old_message)
					if current_game.current_player.name ~ current_game.playerx.name then
						current_game.set_current_player (current_game.playero)
					else
						current_game.set_current_player (current_game.playerx)
					end
				end
			end
		end

	redo
		do
			execute
		end

feature

	is_valid: BOOLEAN
		do
			Result := player_name /~ "" and player_name ~ current_game.current_player.name and current_game.board.get_symbol(player_position) ~ "_" and current_game.game_over_status ~ false
		end

invariant
	is_position_within_bounds: 1 <= player_position and player_position <= 9

end
