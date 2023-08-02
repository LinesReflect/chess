# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def colored_symbol(color)
    color == 'white' ? '♚' : '♔'
  end

  def find_moves(current_square, board)
    clear_moves
    up_moves(current_square, board, true)
    up_right_moves(current_square, board, true)
    right_moves(current_square, board, true)
    down_right_moves(current_square, board, true)
    down_moves(current_square, board, true)
    down_left_moves(current_square, board, true)
    left_moves(current_square, board, true)
    up_left_moves(current_square, board, true)
  end
end
