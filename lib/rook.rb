# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def colored_symbol(color)
    color == 'white' ? '♜' : '♖'
  end
end
