require_relative 'player'
require_relative 'board'

class ChessGame
  def initialize

    @chessboard = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    #TODO: save/load functionality
  end

  def play
    play_turn until over?
    puts "Game over!"
  end

  def play_turn
    input = current_player.make_move(pos, dest)
    chessboard.move(input)
    next_player
  end

  def over?
    @board.checkmate?
  end

  def next_player
    players << players.shift
  end

  def current_player
    players.first
  end

  private
  attr_accessor :chessboard, :players
end


# if __FILE__ == $PROGRAM_NAME
#   puts "Welcome to Chess!"
#   ChessGame.new.play
# end

board = Board.new
p1 = Knight.new([2, 2], board, :black)
queen = Queen.new([3, 3], board, :black)
p2 = Knight.new([4, 4], board, :white)
k1 = Knight.new([0, 0], board, :white)
p3 = Knight.new([1, 5], board, :white)
p4 = Knight.new([3, 6], board, :white)
king = King.new([6, 6], board, :white)

board[[3,3]]= queen
board[[2,2]]= p1
board[[4,4]]= p2
board[[1,5]]= p3
board[[3,6]] = p4
board[[0,0]]= k1
board[[6,6]]= king
p queen.moves
