require_relative 'empty_square'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) { EmptySquare.new } }
    populate_grid
  end


  def populate_grid
    setup_pieces(:black, 0)
    setup_pawns(:black, 1)

    setup_pawns(:white, 6)
    setup_pieces(:white, 7)
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

    @grid.each_with_index do |row, ridx|
      print (ridx + 1).to_s + " "
      row.each_with_index do |elem, cidx|
        print_elem(elem, ridx, cidx)
      end

      puts
    end

    puts "  a  b  c  d  e  f  g  h"
  end

  def print_elem(elem, ridx, cidx)
    if (ridx + cidx) % 2 == 0
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
