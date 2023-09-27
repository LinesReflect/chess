# frozen_string_literal: true

require_relative 'piece'
require_relative 'castle'

class Rook < Piece
  attr_reader :first_move

  include Castle

  def initialize(piece_name, player, color, current_square, fen, symbol = colored_symbol(color))
    super

    @first_move = true
  end

  def change_square(square, board)
    super(square, board)

    @first_move = false
  end

  def colored_symbol(color)
    color == 'white' ? '♜' : '♖'
  end

  def find_moves(current_square, board)
    @moves.clear
    up_moves(current_square, board)
    down_moves(current_square, board)
    right_moves(current_square, board)
    left_moves(current_square, board)
  end
end
