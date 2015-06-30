require_relative 'piece'

class SlidingPiece < Piece

  def initialize(pos, board, color)
    super
  end

  def moves
    all_moves = []

    self.move_diffs.each do |diff|
      drow, dcol = diff
      row, col = pos
      new_pos = [row + drow, col + dcol]

      until !board[new_pos].empty?
        all_moves << new_pos                  # for empty squares
        row, col = new_pos
        new_pos = [row + drow, col + dcol]
      end

      all_moves << new_pos if enemy?(new_pos) # for squares containing an enemy
    end

    all_moves.select { |move| valid_move?(move) }
  end

end

class Rook < SlidingPiece

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end
