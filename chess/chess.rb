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
rook = Rook.new([2, 2], board, :black)
bk1 = Knight.new([0, 2], board, :black)
wk1 = Knight.new([2, 5], board, :white)
wk2 = Knight.new([3, 2], board, :white)
king = King.new([7, 2], board, :white)

board[[2, 2]] = rook
board[[0, 2]] = bk1
board[[2, 5]] = wk1
board[[3, 2]] = wk2
board[[7, 2]] = king
p rook.moves
