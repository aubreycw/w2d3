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
      raise "(╯°□°）╯︵ ┻━┻" if input == "q"
      unless ['w', 'a', 's', 'd', ' ', "\r"].include?(input)
        raise InputError.new
      end
      input

    rescue InputError
      p "rescued"
      retry
    end
  end
end

class ComputerPlayer < Player
end

class InputError < ArgumentError
end

class EndGameError < ArgumentError
end
