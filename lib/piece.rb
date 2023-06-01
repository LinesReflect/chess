# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'square'

class Piece
  def initialize(symbol, color, current_square, player)
    @symbol = symbol
    @color = color
    @current_square = current_square
    @player = player
  end
end
