require_relative 'piece'

class Pawn < Piece

  def initialize(pos, board, color, moved = false)
    super(pos, board, color)
    @moved = moved
    @id = "♙"
  end

  def dup(duped_board)
    Pawn.new(pos, duped_board, color, moved)
  end

  def moves
    #TODO: dry these two out with Procs?
    capture_moves + normal_moves
  end

  def move_to(destination)
    super
    moved = true
  end

  def capture_moves
    moveset = capture_diffs

    all_moves = []
    row, col = pos

    moveset.each do |drow, dcol|
      new_pos = [row + drow, col + dcol]
      all_moves << new_pos if enemy?(new_pos)
    end

    all_moves
  end

  def normal_moves
    all_moves = []
    row, col = pos

    moveset = normal_move_diffs
    moveset.concat(first_move_diffs) unless @moved

    moveset.each do |drow, dcol|
      new_pos = [row + drow, col + dcol]
      if board[pos].empty? && move_on_board(pos) #can't use legal_move?
        all_moves << new_pos
      end
    end

    all_moves
  end

  def normal_move_diffs
    color == :black ? [[0,1]] : [[0, -1]]
  end

  def first_move_diffs
    color == :black ? [[0,2]] : [[0, -2]]
  end

  def capture_diffs
    color == :black ? [[1, 1], [-1, 1]] : [[1, -1], [-1, -1]]
  end

  private
  attr_reader :pos, :board, :color, :moved
end
