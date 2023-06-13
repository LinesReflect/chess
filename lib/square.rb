# frozen_string_literal: true

require 'colorize'

class Square
  attr_reader :row, :column, :piece_on_square

  def initialize(row, column, piece_on_square = nil)
    @row = row
    @column = column
    @piece_on_square = piece_on_square
  end

  def update_piece(piece)
    @piece_on_square = piece
  end
end
