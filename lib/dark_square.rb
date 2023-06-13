# frozen_string_literal: true

require_relative 'square'
require 'colorize'

class DarkSquare < Square
  def display_square
    return '   '.colorize(:background => :black) if @piece_on_square.nil?

    " #{@piece_on_square.symbol} ".colorize(:background => :black)
  end
end
