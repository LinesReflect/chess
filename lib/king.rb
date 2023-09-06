# frozen_string_literal: false, true

require_relative 'piece'

class King < Piece
  def colored_symbol(color)
    color == 'white' ? '♚' : '♔'
  end

  def find_moves(current_square, board, enemy_moves)
    @moves.clear
    up_moves(current_square, board, false, true)
    up_right_moves(current_square, board, false, true)
    right_moves(current_square, board, true)
    down_right_moves(current_square, board, false, true)
    down_moves(current_square, board, false, true)
    down_left_moves(current_square, board, false, true)
    left_moves(current_square, board, true)
    up_left_moves(current_square, board, false, true)
    remove_moves_into_check(enemy_moves)
  end

  def remove_moves_into_check(enemy_moves)
    @moves.reject! { |move| enemy_moves.include?(move) } unless enemy_moves.nil?
  end
end
