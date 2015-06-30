class Piece
  attr_reader :color, :board, :pos

  def initialize(pos, board, color)
    @pos = pos
    @color = color
    @board = board
  end

  def empty?
    false
  end

  def moves
    raise "moves not implemented"
    # valid_move?
  end

  def valid_move?(pos)
    move_on_board?(pos) && square_available?(pos)
  end

  def move_on_board?(pos)
    pos.all? { |elem| elem.between?(0, 7) }
  end

  def square_available?(pos)
    board[pos].empty? || enemy?(pos)
  end

  def enemy?(pos)
    move_on_board?(pos) && board[pos].color != self.color
  end
end
