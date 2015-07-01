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
    play_turn until chessboard.checkmate?
    puts "Game over!"
  end

  def play_turn
    #move the cursor around, displaying moves for current player
    message = "It's #{current_player.color.capitalize}'s turn."
    if chessboard.in_check?(current_player.color)
      message += "\n You are currently in check "
    end
    input = get_player_input(message)

    if valid_move(input)
      chessboard.move(input)
      next_player
    end

    #highlight piece's moves until moved or de-selected
    #select a move and move the piece, also check for check/mate status

  end

  def get_player_input(message)
    loop do
      input = input_from_cursor(message)
      break if input
    end

    input
  end

  def input_from_cursor(message)
    chessboard.render
    puts message
    input = current_player.get_input # Player#get_input rescues bad input

    case input
    when ' '
      chessboard.select_pos
      return nil
    when "\r"
      return chessboard.cursor_info
    else
      move_cursor(KEYBINDINGS[input])
      return nil
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
