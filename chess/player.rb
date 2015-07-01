require 'io/console'

class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class HumanPlayer < Player
  def get_input
    begin
      input = $stdin.getch
      unless ['w', 'a', 's', 'd', ' ', "\r"].include?(input)
        raise ArgumentError.new
      end
      input

    rescue ArgumentError
      p "rescued"
      retry
    end
  end
end

class ComputerPlayer < Player
end
