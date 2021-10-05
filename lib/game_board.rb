class Game_Board

    attr_accessor :board

    def initialize 
        @board = Array.new(7) { Array.new(6) }
    end

    def display_board
        0.upto(5) do |i|
          print "|"
          0.upto(6) do |n|
            print @board[n][i].nil? ? "   |" : " #{@board[n][i]} |"
          end
          puts
        end
    end

    def column_not_full?(column_number)
        return !(board[column_number-1].all?)
    end

    def valid_move?(column_number)
        return false if column_number > 7 || column_number < 1
        return column_not_full?(column_number)
    end

    def drop_piece(piece, column_number)
        return if !(column_not_full?(column_number))
        cell = @board[column_number-1].count(nil) - 1
        @board[column_number-1][cell] = piece
    end

    def draw?
        draw = false
        @board.each do |column|
          draw = true if column.none? { |cell| cell.nil? }
        end
        draw
    end

    def win?
        return true if four_in_a_row?
        return true if four_in_a_column?
        return true if four_diagonal?
        return false
    end

    def four_in_a_row?
        0.upto(5) do |y|
          0.upto(3) do |x|
            if @board[x][y] == @board[x + 1][y] && @board[x][y] == @board[x + 2][y] && @board[x][y] == @board[x + 3][y]
              return true unless @board[x][y].nil?
            end
          end
        end
        false
      end
    
    def four_in_a_column?
        0.upto(6) do |x|
          0.upto(2) do |y|
            if @board[x][y] == @board[x][y + 1] && @board[x][y] == @board[x][y + 2] && @board[x][y] == @board[x][y + 3]
              return true unless @board[x][y].nil?
            end
          end
        end
        false
     end
    
    def four_diagonal?
        0.upto(2) do |x|
          0.upto(3) do |y|
            if @board[x][y] == @board[x+1][y+1] && @board[x][y] == @board[x+2][y+2] && @board[x][y] == @board[x+3][y+3]
              return true unless @board[x][y].nil?
            end
          end
        end
        6.downto(3) do |x|
          0.upto(3) do |y|
            if @board[x][y] == @board[x-1][y+1] && @board[x][y] == @board[x-2][y+2] && @board[x][y] == @board[x-3][y+3]
              return true unless @board[x][y].nil?
            end
          end
        end
        false
    end
end