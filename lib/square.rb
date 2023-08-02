# frozen_string_literal: true

require 'colorize'

class Square
  attr_reader :coords, :rank_and_file, :row, :column, :piece_on_square, :highlight_dot

  def initialize(coords, rank_and_file)
    @coords = coords
    @rank_and_file = rank_and_file
    @column = coords[0]
    @row = coords[1]
    @piece_on_square = nil
    @highlight_dot = "\u2022"
  end

  def update_piece(piece)
    @piece_on_square = piece
  end

  def no_piece
    @piece_on_square = nil
  end
end
