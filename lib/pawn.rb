# frozen_string_literal: true

require_relative 'en_passant'
require_relative 'piece'

class Pawn < Piece
  attr_reader :en_passant

  include EnPassant

  def initialize(piece_name, player, color, current_square, fen, symbol = colored_symbol(color))
    super

    @first_move = true
    @en_passant = false
  end

  def change_square(square, board)
    signal_captured_pawn(@square_to_signal) if en_passant_chosen?(square)
    super
    @en_passant = true if en_passant?

    @first_move = false
  end

  def colored_symbol(color)
    color == 'white' ? '♟︎' : '♙'
  end

  def find_moves(current_square, board)
    @moves.clear
    @color == 'white' ? find_white_moves(current_square, board) : find_black_moves(current_square, board)
    find_en_passant_capture(board)
  end

  def find_white_moves(current_square, board)
    up_left_moves(current_square, board, true)
    up_right_moves(current_square, board, true)
    @moves.delete_if { |square| square.piece_on_square.nil? }
    pawn_double_move(current_square, board)
    up_moves(current_square, board, true)
  end

  def find_black_moves(current_square, board)
    down_left_moves(current_square, board, true)
    down_right_moves(current_square, board, true)
    @moves.delete_if { |square| square.piece_on_square.nil? }
    pawn_double_move(current_square, board)
    down_moves(current_square, board, true)
  end

  def remove_en_passant
    @en_passant = false
  end
end
