# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'square'
require_relative 'movesets'

class Piece
  attr_reader :piece_name, :player, :color, :current_square, :fen, :symbol, :moves, :check_move, :remove_check_moves

  include Movesets

  def initialize(piece_name, player, color, current_square, fen, symbol = colored_symbol(color))
    @piece_name = piece_name
    @player = player
    @color = color
    @current_square = current_square
    @fen = fen
    @symbol = symbol
    @moves = []
    @check_moves = []
    @remove_check_moves = []
  end

  def change_square(square, board)
    capture_move(square) unless square.piece_on_square.nil?
    current_square_remove_piece
    @current_square = square
    claim_square
  end

  def capture_move(square)
    @player.captured_piece(square.piece_on_square, square.piece_on_square.player)
  end

  def claim_square
    current_square.update_piece(self)
  end

  def print_moves
    i = 0
    while i < @moves.length
      print "#{i + 1}.#{moves[i].rank_and_file}"
      i == @moves.length - 1 ? print("\n") : print(' ')
      i += 1
    end
  end

  def refresh_possible_moves(new_moves)
    @moves = new_moves
  end

  def current_square_remove_piece
    @current_square.no_piece
  end

  def pinned?(enemy_moves)
    return true if enemy_moves.any? { |move| move.piece_on_square.instance_of?(King)}

    false
  end

  def checking_enemy_king?
    return true if @moves.any? { |move| move.piece_on_square.instance_of?(King)}

    false
  end
end
