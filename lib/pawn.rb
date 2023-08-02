# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def colored_symbol(color)
    color == 'white' ? '♟︎' : '♙'
  end

  def find_moves(current_square, board)
    clear_moves
    @color == 'white' ? white_pawn_moves(current_square, board) : black_pawn_moves(current_square, board)
  end
end
