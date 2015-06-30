require_relative 'piece'

class SteppingPiece < Piece
  def initialize(pos, board, color)
    super
  end

  def moves
    all_moves = []

    self.move_diffs.each do |diff|
      drow, dcol = diff
      row, col = pos
      all_moves << [row + drow, col + dcol]
    end

    all_moves.select { |move| self.valid_move?(move) }
  end
end


class King < SteppingPiece
  def initialize(pos, board, color)
    super
  end

  def move_diffs
    [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]
  end
end

class Knight < SteppingPiece
  def initialize(pos, board, color)
    super
  end

  def move_diffs
    all_moves = []
    [1,-1].each do |x|
      [2,-2].each do |y|
        all_moves << [x, y]
        all_moves << [y, x]
      end
    end
    all_moves
  end

end
