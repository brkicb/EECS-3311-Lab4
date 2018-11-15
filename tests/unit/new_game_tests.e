note
	description: "Summary description for {NEW_GAME_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_GAME_TESTS

inherit

	ES_TEST

create
	make

feature

	make
		do
			add_boolean_case (agent test_execute)
			add_boolean_case (agent test_undo)
		end

feature -- boolean

	test_execute: BOOLEAN
		local
			i: INTEGER
			ttt: TTT
			new_game_opt: NEW_GAME
		do
			comment ("test 'execute'")
			create ttt.make
			print (ttt.out + "%N") --Initial state
			ttt.player_x.set_name ("T")
			ttt.player_o.set_name ("K")
			ttt.player_x.set_score (10)
			ttt.player_o.set_score (20)
			ttt.set_next (ttt.player_o)
			ttt.board.move (5, ttt.player_x)
				--a random game point
			create new_game_opt.make (ttt, "Tao", "Kevin")
			new_game_opt.execute
			ttt.history.extend (new_game_opt)
			check
				ttt.player_x.name ~ "Tao" and ttt.player_x.score = 0
			end
			check
				ttt.player_o.name ~ "Kevin" and ttt.player_o.score = 0
			end
			check
				ttt.next = ttt.player_x
			end
			from
				i := 1
			until
				i > 9
			loop
				check
					ttt.board.board [i] ~ "_"
				end
				i := i + 1
			end
			print (ttt.out + "%N") --after start a new game


			create ttt.make
			ttt.player_x.set_name ("T")
			ttt.player_o.set_name ("K")
			ttt.player_x.set_score (10)
			ttt.player_o.set_score (20)
			ttt.set_next (ttt.player_o)
			ttt.board.move (5, ttt.player_x)
			create new_game_opt.make (ttt, "Tao", "Tao")
			new_game_opt.execute
			ttt.history.extend (new_game_opt)
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			check
				ttt.board.board [5] ~ "X"
			end
			check
				ttt.message.message ~ "names of players must be different"
			end
			check
				new_game_opt.has_error
			end
			print (ttt.out + "%N")


			create ttt.make
			ttt.player_x.set_name ("T")
			ttt.player_o.set_name ("K")
			ttt.player_x.set_score (10)
			ttt.player_o.set_score (20)
			ttt.set_next (ttt.player_o)
			ttt.board.move (5, ttt.player_x)
			create new_game_opt.make (ttt, "#", "Tao")
			new_game_opt.execute
			ttt.history.extend (new_game_opt)
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			check
				ttt.board.board [5] ~ "X"
			end
			check
				ttt.message.message ~ "name must start with A-Z or a-z"
			end
			check
				new_game_opt.has_error
			end
			print (ttt.out + "%N")

			Result := true
		end

	test_undo: BOOLEAN
		local
			i: INTEGER
			ttt: TTT
			new_game_opt: NEW_GAME
		do
			comment ("test 'undo'")
			create ttt.make
			print (ttt.out + "%N") --Initial state
			ttt.player_x.set_name ("T")
			ttt.player_o.set_name ("K")
			ttt.player_x.set_score (10)
			ttt.player_o.set_score (20)
			ttt.set_next (ttt.player_o)
			ttt.message.set_message ("THIS IS A TEST")
			ttt.board.move (5, ttt.player_x)
			create new_game_opt.make (ttt, "Tao", "Kevin")
			new_game_opt.execute
			ttt.history.extend (new_game_opt)
			new_game_opt.undo
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			check ttt.board.board[5] ~ "X" end
			check ttt.message.message ~ "THIS IS A TEST" end
			-- another new game operation
			create new_game_opt.make (ttt, "#", "Kevin")
			new_game_opt.execute
			ttt.history.extend (new_game_opt)
			new_game_opt.undo
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			check ttt.board.board[5] ~ "X" end
			check ttt.message.message ~ "THIS IS A TEST" end

			Result := true
		end

feature --violation

end
