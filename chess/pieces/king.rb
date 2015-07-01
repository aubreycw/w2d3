require_relative 'stepping_piece'

class King < SteppingPiece
  MOVE_DIFFS = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]

    def initialize(pos, board, color, moved = false)
      super
      @id = "♔"
      @moved = moved
    end

    def move_to(destination)
      super
      @moved = true
    end

    def king?
      true
    end

    def king_location
      @pos
    end
end
