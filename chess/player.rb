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
      raise QuitGame if input == "p"

      unless ['w', 'a', 's', 'd', ' ', "\r", "q"].include?(input)
        raise InputError.new
      end

      input
    rescue InputError
      retry
    end
  end
end

class ComputerPlayer < Player
end

class InputError < ArgumentError
end

class QuitGame < ArgumentError
end
