# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def colored_symbol(color)
    color == 'white' ? '♞' : '♘'
  end

  def find_moves(current_square, board)
    clear_moves
    knight_moves(current_square, board)
  end
end
