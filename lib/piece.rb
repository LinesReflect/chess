# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'square'
require_relative 'movesets'

class Piece
  attr_reader :player, :color, :current_square, :fen, :symbol, :moves

  include Movesets

  def initialize(player, color, current_square, fen, symbol = colored_symbol(color))
    @player = player
    @color = color
    @current_square = current_square
    @fen = fen
    @symbol = symbol
    @moves = []
  end

  def change_square(square)
    @current_square.no_piece
    @current_square = square
    claim_square
  end

  def claim_square
    current_square.update_piece(self)
  end

  def clear_moves
    @moves = []
  end

  def print_moves
    i = 0
    while i < @moves.length
      print "#{i + 1}.#{moves[i].rank_and_file}"
      i == @moves.length - 1 ? print("\n") : print(' ')
      i += 1
    end
  end
end
