note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD_TESTS

inherit

	ES_TEST

create
	make

feature

	make
		do
			add_boolean_case (agent test_out)
			add_boolean_case (agent test_move)
			add_boolean_case (agent test_check_win)
		end

feature -- boolean

	test_out: BOOLEAN
		local
			board: BOARD_3x3
		do
			comment ("test the representation string of the board")
			create board.make
			print (board.out)
			Result := true
		end

	test_move: BOOLEAN
		local
			board: BOARD_3x3
			player_x: PLAYER_X
			player_o: PLAYER_O
			i: INTEGER
		do
			comment ("test the players' moves on the board")
			create board.make
			create player_x.make ("Tao")
			create player_o.make ("Kevin")
			board.move (1, player_x)
			check
				board.square (1) ~ "X"
			end
			board.move (2, player_o)
			check
				board.square (2) ~ "O"
			end
			from
				i := 3
			until
				i > 9
			loop
				check
					board.square (i) ~ "_"
				end
				i := i + 1
			end
			Result := true
		end

	test_check_win: BOOLEAN
		local
			board: BOARD_3x3
			player_x: PLAYER_X
			player_o: PLAYER_O
			winner: INTEGER
		do
			create player_x.make ("Tao")
			create player_o.make ("Kevin")
			comment ("test check_win")
			sub_comment ("test PLAYERX wins")
			create board.make
			board.move (1, player_x)
			board.move (2, player_x)
			board.move (4, player_o)
			board.move (5, player_o)
			board.move (3, player_x)
			winner := board.check_win
			check
				winner = 1
			end
			sub_comment ("test PLAYERO_wins")
			create board.make
			board.move (1, player_o)
			board.move (2, player_o)
			board.move (4, player_x)
			board.move (5, player_x)
			board.move (3, player_o)
			winner := board.check_win
			check
				winner = 2
			end
			sub_comment ("test draw")
			create board.make
			board.move (1, player_x)
			board.move (2, player_x)
			board.move (3, player_o)
			board.move (4, player_o)
			board.move (5, player_o)
			board.move (6, player_x)
			board.move (7, player_x)
			board.move (8, player_o)
			board.move (9, player_x)
			winner := board.check_win
			check
				winner = 3
			end
			sub_comment ("test in_progress")
			create board.make
			board.move (1, player_x)
			board.move (2, player_x)
			board.move (3, player_o)
			board.move (4, player_o)
			board.move (5, player_o)
			print(board.out)
			winner := board.check_win
			check
				winner = 4
			end

			Result := true
		end

feature --violation

end
