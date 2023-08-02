# frozen_string_literal: true

require_relative 'piece'
require_relative 'square'
require_relative 'dark_square'
require_relative 'light_square'
require 'colorize'

class Board
  attr_reader :squares, :rows, :fen

  def initialize(squares = create_squares, rows = board_rows(squares))
    @squares = squares
    @rows = rows
    @fen = nil
  end

  def create_squares
    square_array = []
    files = ('a'..'h').to_a
    row = 1
    color = 'black'
    while row < 9
      column = 1
      while column < 9
        square = color == 'black' ? DarkSquare.new([column, row], "#{files[column - 1]}#{row}") : LightSquare.new([column, row], "#{files[column - 1]}#{row}")
        square_array.push(square)
        column += 1
        color = color == 'black' ? 'light_black' : 'black' unless (square_array.length % 8).zero?
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

  def display_board(highlights = nil)
    puts file_grid
    update_board(highlights)
    puts file_grid
  end

  def update_board(highlights)
    rank = 8
    @rows.values.reverse.each do |row|
      print "#{rank} "
      row.each do |square|
        if highlights.nil?
          print square.display_square
        else
          print highlights.include?(square) ? square.display_square(true) : square.display_square
        end
      end
      print " #{rank} "
      puts ''
      rank -= 1
    end
  end

  def file_grid
    '   a  b  c  d  e  f  g  h'
  end

  def to_fen
    row_num = 1
    fen = ''
    rows.values.reverse.each do |row|
      empty_sum = 0
      row.each do |square|
        if square.piece_on_square.nil?
          empty_sum += 1
        else
          fen += empty_sum.to_s unless empty_sum.zero?
          fen += square.piece_on_square.fen
          empty_sum = 0
        end
      end
      fen += empty_sum.to_s unless empty_sum.zero?
      fen += '/' unless row_num == 8
      empty_sum = 0
      row_num += 1
    end
    @fen = fen
  end
end
