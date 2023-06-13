# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'square'

class Piece
  attr_reader :player, :color, :current_square, :symbol

  def initialize(player, color, current_square, symbol = colored_symbol(color))
    @player = player
    @color = color
    @current_square = current_square
    @symbol = symbol
  end

  def claim_square
    current_square.update_piece(self)
  end
end
