# frozen_string_literal: false, true

require_relative 'piece'

class King < Piece
  def colored_symbol(color)
    color == 'white' ? '♚' : '♔'
  end

  def find_moves(current_square, board)
    clear_moves
    up_moves(current_square, board, false, true)
    up_right_moves(current_square, board, false, true)
    right_moves(current_square, board, false, true)
    down_right_moves(current_square, board, false, true)
    down_moves(current_square, board, false, true)
    down_left_moves(current_square, board, false, true)
    left_moves(current_square, board, false, true)
    up_left_moves(current_square, board, false, true)
  end
end
