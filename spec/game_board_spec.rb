#spec/game_board_spec.rb
require './lib/game_board'

describe Game_Board do

    context "Creating a new board object" do
        board_game = Game_Board.new

        describe "#initialize" do
            it "Creates an array with 7 columns" do
                expect(board_game.board.size).to eq(7)
            end
    
            it "Each column has an array with 6 pieceholders" do
                expect(board_game.board.all? { |pieceholder| pieceholder.size == 6}).to eq(true)
            end
        end
    end

    context "Check if moves are valid" do
        board_game = Game_Board.new
        board_game.board[0] = ["O", "X", "O", "X", "O", "X"]
        board_game.board[1] = [nil, nil, nil, "X", "O", "X"]

        describe "#column_not_full?" do
            it "return true when chosen column is empty" do
              expect(board_game.column_not_full?(7)).to eq true
            end
      
            it "return true when chosen column is partially filled" do
              expect(board_game.column_not_full?(2)).to eq true
            end
      
            it "return false when chosen column is full" do
              expect(board_game.column_not_full?(1)).to eq false
            end
        end

        describe "#valid_move?" do
            it "return false when choice is out of bounds" do
              expect(board_game.valid_move?(8)).to eq false
            end
      
            it "return true when choice is between 1 and 7" do
              expect(board_game.valid_move?(4)).to eq true
            end
      
            it "return false when choice is in bounds but column is full" do
              expect(board_game.valid_move?(1)).to eq false
            end
      
            it "return true when choice is valid and column is not full" do
              expect(board_game.valid_move?(2)).to eq true
            end
        end
    end

    context "making a move" do
        board_game = Game_Board.new

        describe "#drop_piece" do
          it "should drop piece in the correct column" do
            board_game.drop_piece("X", 1)
            expect(board_game.board[0]).to eq([nil, nil, nil, nil, nil, "X"])
            board_game.drop_piece("O", 2)
            expect(board_game.board[1]).to eq([nil, nil, nil, nil, nil, "O"])
          end
    
          it "should drop piece on top of already placed pieces" do
            board_game.drop_piece("X", 1)
            board_game.drop_piece("O", 2)
            expect(board_game.board[0]).to eq([nil, nil, nil, nil, "X", "X"])
            expect(board_game.board[1]).to eq([nil, nil, nil, nil, "O", "O"])
          end
        end
    end

    context "checking for game over" do
        board_game = Game_Board.new
        describe "#draw?" do
          it "should return false when board is not full" do
            expect(board_game.draw?).to eq false
          end
    
          it "should return true when board is full" do
            board_game.board.fill(["O", "O", "O", "O", "O", "O"])
            expect(board_game.draw?).to eq true
          end
        end
    
        describe "#four_in_a_row?" do
          it "should return true when there are four of the same pieces in a row" do
            board_game = Game_Board.new
            board_game.drop_piece("O", 1)
            board_game.drop_piece("O", 2)
            board_game.drop_piece("O", 3)
            board_game.drop_piece("O", 4)
            p board_game.board
            expect(board_game.four_in_a_row?).to eq true
          end
    
          it "should return true when the four in a row are in a higher row" do
            board_game = Game_Board.new
            board_game.board[2] = [nil, "O", nil, nil, nil, nil]
            board_game.board[3] = [nil, "O", nil, nil, nil, nil]
            board_game.board[4] = [nil, "O", nil, nil, nil, nil]
            board_game.board[5] = [nil, "O", nil, nil, nil, nil]
            expect(board_game.four_in_a_row?).to eq true
          end
    
          it "should return false when no player has four in a row" do
            board_game = Game_Board.new
            expect(board_game.four_in_a_row?).to eq false
          end
        end
    
        describe "#four_in_a_column?" do
          it "should return false when there aren't four in a column" do
            expect(board_game.four_in_a_column?).to eq false
          end
    
          it "should return true when there are four in a row in the first column" do
            board_game.board[0] = [nil, nil, "O", "O", "O", "O"]
            expect(board_game.four_in_a_column?).to eq true
          end
    
          it "should return true when there are four in a row in any column" do
            board_game = Game_Board.new
            board_game.board[4] = [nil, nil, "O", "O", "O", "O"]
            expect(board_game.four_in_a_column?).to eq true
          end
        end
    
        describe "#four_diagonal?" do
          it "should return false when there is no diagonal four in a row" do
            board_game = Game_Board.new
            expect(board_game.four_diagonal?).to eq false
          end
    
          it "should return true when there are four in a row diagonally forward" do
            board_game = Game_Board.new
            board_game.board[0][0] = "O"
            board_game.board[1][1] = "O"
            board_game.board[2][2] = "O"
            board_game.board[3][3] = "O"
            expect(board_game.four_diagonal?).to eq true
          end
    
          it "should return true when there are four in a row diagonally backward" do
            board_game = Game_Board.new
            board_game.board[6][0] = "O"
            board_game.board[5][1] = "O"
            board_game.board[4][2] = "O"
            board_game.board[3][3] = "O"
            expect(board_game.four_diagonal?).to eq true
          end
    
          it "should return true when there are four in a row anywhere" do
            board_game = Game_Board.new
            board_game.board[6][2] = "O"
            board_game.board[5][3] = "O"
            board_game.board[4][4] = "O"
            board_game.board[3][5] = "O"
            expect(board_game.four_diagonal?).to eq true
          end
        end
    
        describe "#win?" do
          it "should return false with no win" do
            board_game = Game_Board.new
            expect(board_game.win?).to eq false
          end
    
          it "should return true with a vertical win" do
            board_game = Game_Board.new
            board_game.board[0][0] = "O"
            board_game.board[0][1] = "O"
            board_game.board[0][2] = "O"
            board_game.board[0][3] = "O"
            expect(board_game.win?).to eq true
          end
    
          it "should return true with a horizontal win" do
            board_game = Game_Board.new
            board_game.board[0][0] = "O"
            board_game.board[1][0] = "O"
            board_game.board[2][0] = "O"
            board_game.board[3][0] = "O"
            expect(board_game.win?).to eq true
          end
    
          it "should return true with a diagonal win" do
            board_game = Game_Board.new
            board_game.board[0][0] = "O"
            board_game.board[1][1] = "O"
            board_game.board[2][2] = "O"
            board_game.board[3][3] = "O"
            expect(board_game.win?).to eq true
          end
        end
    end
end