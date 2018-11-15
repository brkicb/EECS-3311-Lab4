note
	description: "Summary description for {TTT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTT_TESTS

inherit

	ES_TEST

create
	make

feature

	make
		do
			add_boolean_case (agent test_remove_all_right)
			add_boolean_case (agent test_new_game)
			add_boolean_case (agent test_play)
			add_boolean_case (agent test_play_agian)
		end

feature -- boolean
	test_remove_all_right: BOOLEAN
		local
			ttt: TTT
		do
			comment("test the command 'remove_all_right'")
			create ttt.make
			ttt.history.extend (create {NEW_GAME}.make (ttt, "Tao", "Kevin"))
			ttt.history.extend (create {PLAY}.make (ttt, "Tao", 1))
			ttt.history.extend (create {PLAY}.make (ttt, "Kevin", 2))
			ttt.history.extend (create {PLAY}.make (ttt, "Tao", 3))
			ttt.history.finish
			ttt.history.back
			ttt.history.back
			ttt.remove_all_right
			check ttt.history.count = 2 end

			Result := true
		end

	test_new_game:BOOLEAN
	local
		ttt: TTT
	do
		comment("test the command 'new_game'")
		create ttt.make
		check ttt.history.is_empty end
		ttt.new_game ("T", "K")
		check not ttt.history.is_empty and ttt.history.count = 1 and ttt.history.islast end
		check attached {NEW_GAME} ttt.history.item end

		ttt.new_game ("#", "K")
		ttt.new_game ("T", "T")
		check ttt.history.count = 3 and ttt.history.islast end

		ttt.history.back
		check not ttt.history.islast end
		ttt.new_game ("K", "K")
		check ttt.history.count = 3 and ttt.history.islast end

		Result := true
	end

	test_play: BOOLEAN
	local
			i: INTEGER
			ttt: TTT
			play: PLAY
			board: BOARD_3x3
	do
		comment("test the command 'play'")
		create ttt.make
		ttt.new_game ("T", "K")
		ttt.play ("T", 1)
		check ttt.history.islast and ttt.history.count = 2 and ttt.next.name ~ "K" end
		ttt.play ("T", 2)
		check ttt.history.islast and ttt.history.count = 3 and ttt.next.name ~ "K" and ttt.history.last.has_error end
		ttt.play ("K", 4)
		ttt.play ("T", 2)
		ttt.play ("K", 5)
		ttt.play ("T", 3)
		print(ttt.out)
		check ttt.game_over and ttt.player_x.score = 1 and ttt.history.count = 1 end

		Result := true
	end

	test_play_agian: BOOLEAN
	local
		ttt:TTT
	do
		comment("test the command 'play_agian'")
		create ttt.make
		ttt.new_game ("T", "K")
		ttt.play ("T", 1)
		ttt.play_again
		check ttt.history.islast and ttt.history.count = 3 and ttt.history.last.has_error
		and attached {PLAY_AGAIN} ttt.history.last end
		ttt.play ("K", 4)
		ttt.play ("T", 2)
		ttt.play ("K", 5)
		ttt.play ("T", 3)
		ttt.play_again
		check ttt.history.count = 1 and not ttt.game_over and ttt.player_x.score = 1 end

		Result := true
	end


end
