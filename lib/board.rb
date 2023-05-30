# frozen_string_literal: true

require_relative 'square'
require_relative 'dark_square'
require_relative 'light_square'
require 'colorize'

class Board
  attr_reader :squares, :rows

  def initialize(squares = create_squares, rows = board_rows(squares))
    @squares = squares
    @rows = rows
  end

  def create_squares
    square_array = []
    row = 1
    color = 'light_black'
    while row < 9
      column = 1
      while column < 9
        square = color == 'light_black' ? DarkSquare.new(row, column) : LightSquare.new(row, column)
        square_array.push(square)
        column += 1
        color = color == 'light_black' ? 'light_white' : 'light_black' unless (square_array.length % 8).zero?
      end
      row += 1
    end
    square_array
  end

  def board_rows(squares)
    rows = {}
    i = 1
    while i < 9
      row = []
      squares.each { |square| row.push(square) if square.row == i}
      rows["row_#{i}"] = row
      i += 1
    end
    rows
  end

  def display_board
    puts file_grid
    update_board
    puts file_grid
  end

  def update_board
    rank = 8
    @rows.values.reverse.each do |row|
      print "#{rank} "
      row.each do |square|
        print square.display_square
      end
      print " #{rank} "
      puts ''
      rank -= 1
    end
  end

  def file_grid
    '   a  b  c  d  e  f  g  h'
  end
end
