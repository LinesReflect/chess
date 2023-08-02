# frozen_string_literal: true

require_relative 'square'
require 'colorize'

class LightSquare < Square
  def display_square(highlight = false)
    return " #{@highlight_dot} ".colorize(:background => :light_black) if highlight && !@piece_on_square
    return " #{@piece_on_square.symbol} ".colorize(:background => :light_red) if highlight && @piece_on_square
    return '   '.colorize(:background => :light_black) if @piece_on_square.nil?

    " #{@piece_on_square.symbol} ".colorize(:background => :light_black)
  end
end
