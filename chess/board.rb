require_relative 'empty_square'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) { EmptySquare.new } }
    #populate_grid
  end
  def populate_grid
    # instantiates squares with the proper chess pieces
    raise "Grid is not populated yet~"
  end

  def render
    @grid.each do |row|
      row.each do |elem|
        print elem.to_s
      end
      puts
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
