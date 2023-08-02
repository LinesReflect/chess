# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def colored_symbol(color)
    color == 'white' ? '♝' : '♗'
  end

  def find_moves(current_square, board)
    clear_moves
    up_right_moves(current_square, board)
    up_left_moves(current_square, board)
    down_right_moves(current_square, board)
    down_left_moves(current_square, board)
  end
end
