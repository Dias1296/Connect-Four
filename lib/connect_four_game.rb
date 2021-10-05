require_relative "player.rb"
require_relative "game_board.rb"

class Connect_Four_Game

    attr_accessor :game_board, :player1, :player2, :current_player

    def initialize
        @game_board = Game_Board.new
        @player1 = Player.new('Fabio', 'X')
        @player2 = Player.new('Rayanna', 'O')
        @current_player = @player1
        game_loop
    end

    def switch_current_player
        return @current_player = @player1 if @current_player == @player2
        return @current_player = @player2 if @current_player == @player1
    end

    def game_loop
        puts "Welcome to Connect Four!"
        loop do
          @game_board.display_board
          puts "#{@current_player.name} choose a column (1-7) to make your move."
          column = get_move
          @game_board.drop_piece(@current_player.symbol, column)
          check_game_over
          switch_current_player
        end
      end
    
      def get_move
        choice = gets.chomp.to_i
        if !@game_board.column_not_full?(choice)
          puts "That column is filled. Try again."
          get_move
        elsif !@game_board.valid_move?(choice)
          puts "Out of bounds. Choice must be between 1 and 7."
          get_move
        end
        choice
      end
    
      def win_message
        puts "Congratulations #{@current_player.name}, you win!"
        @game_board.display_board
        reset_game
      end
    
      def draw_message
        puts "Looks like we have a draw!"
        @game_board.display_board
        reset_game
      end
    
      def check_game_over
        if @game_board.win?
          win_message
        elsif @game_board.draw?
          draw_message
        end
      end
    
      def play_again?
        puts "Would you like to play again? (y/n)"
        input = gets.chomp
        if input == "y"
          return true
        elsif input == "n"
          return false
        else
          puts "Invalid input."
          play_again?
        end
      end
    
      def reset_game
        if play_again?
            Connect_Four_Game.new
        else
          exit
        end
    end
end

game = Connect_Four_Game.new