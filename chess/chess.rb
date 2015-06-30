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


if __FILE__ == $PROGRAM_NAME
  puts "Welcome to Chess!"
  ChessGame.new.play
end
