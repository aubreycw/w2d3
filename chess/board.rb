require_relative 'empty_square'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require 'colorize'

class Board
  attr_accessor :grid, :selected_piece, :cursor_pos, :selected_piece

  def initialize
    @grid = Array.new(8) {Array.new(8) { EmptySquare.new } }
    @cursor_pos= [0, 0]
    @selected_piece = nil
    populate_grid
  end

  def move_cursor(diff)
    p cursor_pos
    drow, dcol = diff
    row, col = cursor_pos

    new_pos = [row + drow, col + dcol]
    if self.move_on_board?(new_pos)
      p new_pos
      self.cursor_pos = new_pos
    end
  end

  def populate_grid
    setup_pieces(:black, 0)
    setup_pawns(:black, 1)

    setup_pawns(:white, 6)
    setup_pieces(:white, 7)
  end

  def move_on_board?(pos)
    pos.all? { |elem| elem.between?(0, 7) }
  end

  def setup_pawns(color, row)
    (0..7).each do |col|
      grid[row][col] = Pawn.new([row, col], self, color)
    end
  end

  def setup_pieces(color, row)
    pieces = [
      Rook.new([row, 0], self, color),
      Knight.new([row, 1], self, color),
      Bishop.new([row, 2], self, color),
      Queen.new([row, 3], self, color),
      King.new([row, 4], self, color),
      Bishop.new([row, 5], self, color),
      Knight.new([row, 6], self, color),
      Rook.new([row, 7], self, color)
    ]

    (0..7).each { |col| grid[row][col] = pieces.shift }
  end

  def render
    system("clear")
    @grid.each_with_index do |row, ridx|
      print (ridx + 1).to_s + " "
      row.each_with_index do |elem, cidx|
        print_elem(elem, ridx, cidx)
      end

      puts
    end

    puts "   a  b  c  d  e  f  g  h"
  end

  def print_elem(elem, ridx, cidx)

    if cursor_pos == [ridx, cidx]
      print " #{elem.to_s} ".on_green
    elsif (ridx + cidx) % 2 == 0
      print " #{elem.to_s} ".on_blue
    else
      print " #{elem.to_s} ".on_red
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, input)
    row, col = pos
    @grid[row][col] = input
  end

end
