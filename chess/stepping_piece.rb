require_relative 'piece'

class SteppingPiece < Piece
  def initialize(pos, board, color)
    super
  end

  def moves
    all_moves = []
    row, col = pos

    self.class::MOVE_DIFFS.each do |drow, dcol|
      new_move = [row + drow, col + dcol]
      all_moves << new_move if valid_move?(new_move)
    end

    all_moves
  end
end


class King < SteppingPiece
  MOVE_DIFFS = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]

    def initialize
      super
      @id = ♔
    end

    def king?
      true
    end
end

class Knight < SteppingPiece
  MOVE_DIFFS = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                [2, 1], [2, -1], [-2, 1], [-2, -1]]

  def initialize
    super
    @id = ♘
  end
end
