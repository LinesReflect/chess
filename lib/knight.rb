# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def colored_symbol(color)
    color == 'white' ? '♞' : '♘'
  end
end
