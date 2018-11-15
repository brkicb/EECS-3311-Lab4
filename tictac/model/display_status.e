note
	description: "Summary description for {DISPLAY_STATUS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_STATUS

create
	make

feature -- Attributes

	ok_status: STRING = "ok"
	different_names: STRING = "names of players must be different"
	start_of_name: STRING = "name must start with A-Z or a-z"
	not_player_turn: STRING = "not this player's turn"
	player_not_exist: STRING = "no such player"
	button_taken: STRING = "button already taken"
	winner: STRING = "there is a winner"
	finish: STRING = "finish this game first"
	game_finished: STRING = "game is finished"
	tie_game: STRING = "game ended in a tie"
	new_game: STRING = "start new game"
	play_again_new_game: STRING = "play again or start new game"
	current_status: STRING
	current_message: STRING

feature -- Constructor

	make
		do
			current_status := ""
			current_message := ""
		end

feature -- Queries

	get_ok_status: STRING
		do
			Result := ok_status
		end

	get_different_names: STRING
		do
			Result := different_names
		end

	get_start_of_name: STRING
		do
			Result := start_of_name
		end

	get_not_player_turn: STRING
		do
			Result := not_player_turn
		end

	get_player_not_exist: STRING
		do
			Result := player_not_exist
		end

	get_button_taken: STRING
		do
			Result := button_taken
		end

	get_winner: STRING
		do
			Result := winner
		end

	get_finish: STRING
		do
			Result := finish
		end

	get_game_finished: STRING
		do
			Result := game_finished
		end

	get_tie_game: STRING
		do
			Result := tie_game
		end

	get_new_game: STRING
		do
			Result := new_game
		end

	get_play_again_new_game: STRING
		do
			Result := play_again_new_game
		end

	get_current_status: STRING
		do
			Result := current_status
		end

	get_current_message: STRING
		do
			Result := current_message
		end

	next(player: STRING) : STRING
		do
			Result := player + " plays next"
		end

feature -- Commands

	set_current_status(s: STRING)
		do
			current_status := s
		end

	set_current_message(s: STRING)
		do
			current_message := s
		end

end
