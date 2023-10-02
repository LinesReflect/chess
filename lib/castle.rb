# frozen_string_literal: true

require_relative 'piece'
require_relative 'board'
require_relative 'square'

module Castle
  def king_castle(current_square, rook_arr, board)
    return if rook_arr.nil?

    column = nil
    rook_arr.map do |rook|
      column = rook.current_square.column == 1 ? 3 : 7
      castle_square = board.squares.select { |square| square.coords == [column, current_square.row] }[0]
      @moves.push(castle_square)
    end
  end

  def signal_rook(king_square, rook_arr, board)
    rook = find_rook(king_square, rook_arr, board)
    square = new_square(rook, board)
    rook.change_square(square, board)
  end

  def find_rook(king_square, rook_arr)
    rook_current_column = king_square.column == 3 ? 1 : 8
    rook_arr.select { |rook| rook.current_square.column == rook_current_column }[0]
  end

  def new_square(rook, board)
    rook_new_column = rook.current_square.column == 1 ? 4 : 6
    board.squares.select { |square| square.coords == [rook_new_column, rook.current_square.row] }[0]
  end

  def castle?(first_move, square)
    return false unless first_move
    return false unless [3, 7].include?(square.column)

    true
  end
end
