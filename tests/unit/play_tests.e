note
	description: "Summary description for {PLAY_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAY_TESTS

inherit

	ES_TEST

create
	make

feature

	make
		do
			add_boolean_case (agent test_execute)
		end

feature -- boolean

	test_execute: BOOLEAN
		local
			i: INTEGER
			ttt: TTT
			play: PLAY
			board: BOARD_3x3
		do
			comment ("test 'execute'")
			create ttt.make
			ttt.player_x.set_name ("T")
			ttt.player_o.set_name ("K")
			ttt.player_x.set_score (10)
			ttt.player_o.set_score (20)
			ttt.set_next (ttt.player_o)
			ttt.board.move (5, ttt.player_x)
				--a random game point
			create play.make (ttt, "T", 1)
			play.execute
			ttt.history.extend (play)
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			from
				i := 1
			until
				i > 9
			loop
				if i = 5 then
					check ttt.board.board[i] ~ "X" end
				else
					check
						ttt.board.board [i] ~ "_"
					end
				end
				i := i + 1
			end
			check ttt.message.message ~ "not this player's turn" end
			print(ttt.out + "%N")

            -- no such player
            create play.make (ttt, "", 1)
			play.execute
			ttt.history.extend (play)
			check
				ttt.player_x.name ~ "T" and ttt.player_x.score = 10
			end
			check
				ttt.player_o.name ~ "K" and ttt.player_o.score = 20
			end
			check
				ttt.next = ttt.player_o
			end
			from
				i := 1
			until
				i > 9
			loop
				if i = 5 then
					check ttt.board.board[i] ~ "X" end
				else
					check
						ttt.board.board [i] ~ "_"
					end
				end
				i := i + 1
			end
			check ttt.message.message ~ "no such player" end

			--button already taken
			create play.make (ttt, "K", 5)
			play.execute
			ttt.history.extend (play)
			check ttt.message.message ~ "button already taken" end
			print(ttt.out + "%N")

			--play right
			create play.make (ttt, "K", 1)
			play.execute
			ttt.history.extend (play)
			check ttt.message.message ~ "ok" end
			check ttt.next = ttt.player_x end
			print(ttt.out + "%N")

			--PlayerX wins
			ttt.board.move (3, ttt.player_x)
			ttt.board.move (2, ttt.player_o)
			create play.make (ttt, "T", 7)
			play.execute
			ttt.history.extend (play)
			check ttt.message.message ~ "there is a winner" end
			check ttt.next = ttt.player_o end
			check ttt.game_over end
			check ttt.player_x.score = 11 end
			print(ttt.out + "%N")

			--Draw
			create board.make
			board.move (1, ttt.player_x)
			board.move (2, ttt.player_x)
			board.move (3, ttt.player_o)
			board.move (4, ttt.player_o)
			board.move (5, ttt.player_o)
			board.move (6, ttt.player_x)
			board.move (7, ttt.player_x)
			board.move (8, ttt.player_o)
--			board.move (9, player_x)
			ttt.set_board (board)
			ttt.set_next (ttt.player_x)
			create play.make (ttt, "T", 9)
			play.execute
			check ttt.message.message ~ "game ended in a tie" end
			check ttt.next = ttt.player_o end
			check ttt.game_over end
			check ttt.player_x.score = 11 end
			check ttt.player_o.score = 20 end
			print(ttt.out + "%N")


			Result := true
		end


feature --violation

end
