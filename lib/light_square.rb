# frozen_string_literal: true

require_relative 'square'
require 'colorize'

class LightSquare < Square
  def display_square
    return '   '.colorize(:background => :light_white) if @piece_on_square.nil?

    "  #{@piece_on_square} ".colorize(:background => :light_white)
  end
end
