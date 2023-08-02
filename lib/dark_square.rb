# frozen_string_literal: true

require_relative 'square'
require 'colorize'

class DarkSquare < Square
  def display_square(highlight = false)
    return " #{@highlight_dot} ".colorize(:background => :black) if highlight && !@piece_on_square
    return " #{@piece_on_square.symbol} ".colorize(:background => :light_red) if highlight && @piece_on_square
    return '   '.colorize(:background => :black) if @piece_on_square.nil?

    " #{@piece_on_square.symbol} ".colorize(:background => :black)
  end
end
