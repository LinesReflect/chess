# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def colored_symbol(color)
    color == 'white' ? '♟︎' : '♙'
  end

  def find_moves(current_square, board)
    clear_moves
    @color == 'white' ? find_white_moves(current_square, board) : find_black_moves(current_square, board)
  end

  def find_white_moves(current_square, board)
    up_left_moves(current_square, board, true)
    up_right_moves(current_square, board, true)
    @moves.delete_if { |square| square.piece_on_square.nil?}
    pawn_double_move(current_square, board)
    up_moves(current_square, board, true)
  end

  def find_black_moves(current_square, board)
    down_left_moves(current_square, board, true)
    down_right_moves(current_square, board, true)
    @moves.delete_if { |square| square.piece_on_square.nil?}
    pawn_double_move(current_square, board)
    down_moves(current_square, board, true)
  end
end
