require_relative 'piece'

class SteppingPiece < Piece
  def initialize(pos, board, color)
    super
  end

  def moves
    all_moves = []
    row, col = pos

    self.move_diffs.each do |drow, dcol|
      new_move = [row + drow, col + dcol]
      all_moves << new_move if valid_move?(new_move)
    end

    all_moves
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

  # make a constant; just hardcode it
  def move_diffs
    all_moves = []
    [1, -1].each do |x|
      [2, -2].each do |y|
        all_moves << [x, y]
        all_moves << [y, x]
      end
    end

    all_moves
  end

end
