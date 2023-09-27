# frozen_string_literal: false, true

require_relative 'piece'
require_relative 'castle'

class King < Piece
  attr_reader :first_move

  include Castle

  def initialize(piece_name, player, color, current_square, fen, symbol = colored_symbol(color))
    super

    @first_move = true
  end

  def colored_symbol(color)
    color == 'white' ? '♚' : '♔'
  end

  def find_moves(current_square, board, enemy_moves)
    @moves.clear
    king_castle(current_square, rooks, board) if @first_move
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

  def change_square(square, board)
    super(square, board)

    signal_rook(square, rooks, board) if castle?(first_move, square)
    @first_move = false
  end

  def rooks
    @player.rooks_for_castle
  end

  def remove_moves_into_check(enemy_moves)
    @moves.reject! { |move| enemy_moves.include?(move) } unless enemy_moves.nil?
  end
end
