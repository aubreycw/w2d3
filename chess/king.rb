require_relative 'stepping_piece'

class King < SteppingPiece
  MOVE_DIFFS = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]

    def initialize(pos, board, color)
      super
      @id = "♔"
    end

    def king?
      true
    end
end
