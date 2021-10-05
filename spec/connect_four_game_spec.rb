#spec/connect_four_game_spec.rb
require './lib/connect_four_game'

describe Connect_Four_Game do
    describe "#initialize" do
        game = Connect_Four_Game.new
        board_game = game.game_board.board
        player1 = game.player1
        player2 = game.player2
        it "should create a blank board" do
          expect(board_game).to be_a(Array)
        end
    
        it "should create an instance of Player class called player1" do
          expect(player1).to be_an_instance_of(Player)
        end
    
        it "should create an instance of Player class called player2" do
          expect(player2).to be_an_instance_of(Player)
        end
    
        it "should set player1 as the current player" do
          expect(game.current_player).to eq(player1)
        end
    end
    
    describe "#switch_current_player" do
        game = Connect_Four_Game.new
        it "should switch from player 1 to player 2" do
          expect(game.switch_current_player).to eq(game.player2)
        end
    
        it "should switch back to player 1" do
          expect(game.switch_current_player).to eq(game.player1)
        end
    end
end