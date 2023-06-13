# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def colored_symbol(color)
    color == 'white' ? '♝' : '♗'
  end
end
