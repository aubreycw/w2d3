require_relative 'player'
require_relative 'board'
require 'io/console'

KEYBINDINGS = { #char => pos or action
  'w' => [-1, 0], 'a' => [0, -1],
  's' => [1, 0],  'd' => [0, 1]
  # ' ' and '\r' key to method names?
}

class ChessGame

  def initialize(player1 = HumanPlayer.new(:white),
                 player2 = HumanPlayer.new(:black))
    @chessboard = Board.new
    @players = [player1, player2]
    chessboard.populate_grid
    #TODO: save/load functionality
  end

  def play
    play_turn until false #fix later
    puts "Game over!"
  end

  def play_turn
    #move the cursor around, displaying moves for current player
    puts "It's #{current_player.color.capitalize}'s turn."
    get_player_input
    #user selects a piece
    #highlight piece's moves until moved or de-selected
    #select a move and move the piece, also check for check/mate status
    next_player
  end

  def get_player_input
    chessboard.render
    input = current_player.get_input # Player#get_input rescues bad input

    case input
    when ' '
      select_piece
    when "\r"
      make_move
    else
      move_cursor(KEYBINDINGS[input])
    end
  end

  def move_cursor(diff)
    chessboard.move_cursor(diff)
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
