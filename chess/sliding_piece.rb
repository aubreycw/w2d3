require_relative 'piece'

class SlidingPiece < Piece

  def initialize(pos, board, color)
    super
  end

  def moves
    all_moves = []

    self.class::MOVE_DIFFS.each do |drow, dcol|
      row, col = pos
      new_pos = [row + drow, col + dcol]

      while move_on_board?(new_pos) && board[new_pos].empty?
        row, col = new_pos
        all_moves << new_pos if valid_move?(new_pos)     # for empty squares
        new_pos = [row + drow, col + dcol]
      end

      all_moves << new_pos if enemy?(new_pos) # for squares containing an enemy
    end

    all_moves
  end

end

class Rook < SlidingPiece
  MOVE_DIFFS = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  def initialize
    super
    @id = ♖
  end
end

class Bishop < SlidingPiece
  MOVE_DIFFS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  def initialize
    super
    @id = ♗
  end
end

class Queen < SlidingPiece
  MOVE_DIFFS = [[1, 1], [1, -1], [-1, 1], [-1, -1],
                [0, 1], [0, -1], [1, 0], [-1, 0]]

  def initialize
    super
    @id = ♕
  end
end
