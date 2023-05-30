# frozen_string_literal: true

require_relative 'square'
require 'colorize'

class DarkSquare < Square
  def display_square
    return '   '.colorize(:background => :light_black) if @piece_on_square.nil?

    "  #{@piece_on_square} ".colorize(:background => :light_black)
  end
end
