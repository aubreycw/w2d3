require_relative 'board_reqs'
require 'colorize'

class Board
  attr_accessor :grid, :selected_pos, :cursor_pos,
                :moves_at_selection

  def initialize
    # sentinel pattern
    @sentinel = EmptySquare.new
    @grid = Array.new(8) {Array.new(8) { EmptySquare.new } }
    @cursor_pos= [0, 0]
    @selected_pos = nil
    @moves_at_selection = []
  end

  def move_cursor(diff)
    p cursor_pos
    drow, dcol = diff
    row, col = cursor_pos

    new_pos = [row + drow, col + dcol]
    if self.move_on_board?(new_pos)
      p new_pos
      self.cursor_pos = new_pos
    end
  end

  def cursor_info
    [selected_pos, cursor_pos]
  end

  def reset_selection
    @selected_pos = nil
    @moves_at_selection = []
  end

  def select_pos(players_color)
    row, col = @cursor_pos
    if grid[row][col].color == players_color
      @selected_pos = [row, col]
      @moves_at_selection = grid[row][col].moves
    end
  end

  def populate_grid
    setup_pieces(:black, 0)
    setup_pawns(:black, 1)

    setup_pawns(:white, 6)
    setup_pieces(:white, 7)
  end

  def setup_pawns(color, row)
    (0..7).each do |col|
      grid[row][col] = Pawn.new([row, col], self, color)
    end
  end

  def setup_pieces(color, row)
    pieces = [
      Rook.new([row, 0], self, color),
      Knight.new([row, 1], self, color),
      Bishop.new([row, 2], self, color),
      Queen.new([row, 3], self, color),
      King.new([row, 4], self, color),
      Bishop.new([row, 5], self, color),
      Knight.new([row, 6], self, color),
      Rook.new([row, 7], self, color)
    ]

    (0..7).each { |col| grid[row][col] = pieces.shift }
  end

  def render
    system("clear")
    @grid.each_with_index do |row, ridx|
      print (ridx + 1).to_s + " "
      row.each_with_index do |elem, cidx|
        print_elem(elem, ridx, cidx)
      end

      puts
    end

    puts "   a  b  c  d  e  f  g  h"
  end

  def debug_info
    puts "Cursor pos: #{cursor_pos}, Selected pos: #{selected_pos}"
  end

  def print_elem(elem, ridx, cidx)
    if cursor_pos == [ridx, cidx]
      print " #{elem.to_s} ".on_green
    elsif selected_pos == [ridx, cidx]
      print " #{elem.to_s} ".on_magenta
    elsif moves_at_selection.include?([ridx, cidx])
      print " #{elem.to_s} ".on_yellow

    # if not special, just make background checkerboard
    elsif (ridx + cidx) % 2 == 0
      print " #{elem.to_s} ".on_blue
    else
      print " #{elem.to_s} ".on_red
    end
  end

  def move_on_board?(pos)
    pos.all? { |elem| elem.between?(0, 7) }
  end

  def in_check?(color)
    king = grid.flatten.select {|piece| piece.king? && piece.color == color}.first
    king_pos = king.pos

    enemies = grid.flatten.select {|piece| piece.color != color}

    enemies.any? { |enemy| enemy.moves.include?(king_pos) }
  end

  def checkmate?(color)
    return false unless in_check?(color)

    allies = grid.flatten.select {|piece| piece.color == color}
    # TODO any? none?
    allies.each { |ally| return false if out_of_check(ally, color)}
    true
  end

  def out_of_check(piece, color)
    origin = piece.pos
    piece.moves.each do |possible_move|
      new_board = self.deep_dup
      new_board.move(origin, possible_move)
      return true unless new_board.in_check?(color)
    end

    false
  end

  def valid_move?(origin, destination) #within rules, and doesn't leave in check
    origin_row, origin_col = origin
    dest_row, dest_col = destination
    piece_to_move = self[origin] # grid[origin_row][origin_col]

    return false unless piece_to_move.can_move_to?(destination)

    new_board = self.deep_dup
    new_board.move!(origin, destination)
    return !new_board.in_check?(piece_to_move.color)
  end

  def move(origin, destination)
    move!(origin, destination) if valid_move?(origin, destination)
  end

  def move!(origin, destination) #no validity checking
    origin_row, origin_col = origin
    dest_row, dest_col = destination

    piece_to_move = grid[origin_row][origin_col]
    raise InvalidMoveError if piece_to_move.empty?
    grid[origin_row][origin_col] = EmptySquare.new

    piece_to_move.move_to(destination) #updates the Piece's pos
    grid[dest_row][dest_col] = piece_to_move  #updates the Board with that Piece
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, input)
    row, col = pos
    @grid[row][col] = input
  end

  def deep_dup
    duped_board = Board.new

    grid.each_with_index do |row, ridx|
      row.each_with_index do |square, cidx|
        duped_pos = [ridx, cidx]
        duped_board[duped_pos] = square.dup(duped_board)
      end
    end
    duped_board
  end

end

# board = Board.new
# board.populate_grid
#
# duped_board = board.deep_dup
# king = King.new([3, 3], duped_board, :black)
# duped_board[[3, 3]] = king
# duped_board.render
#
# sleep(2)
# puts
# puts
#
# board.render
