require_relative 'sliding_piece'

class Rook < SlidingPiece
  MOVE_DIFFS = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  def initialize(pos, board, color)
    super
    @id = "♖"
  end
end
