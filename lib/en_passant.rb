# frozen_string_literal: true

require_relative 'pawn'
require_relative 'square'

module EnPassant
  def en_passant?
    return false unless @first_move
    return false unless [4, 5].include?(@current_square.row)

    true
  end

  def find_en_passant_capture(board)
    left_square = filter_square(find_left_square(board))
    right_square = filter_square(find_right_square(board))
    return if left_square.nil? && right_square.nil?

    if !left_square.nil?
      @color == 'white' ? find_white_en_passant_capture(board, left_square, 'left') : find_black_en_passant_capture(board, left_square, 'left')
      @square_to_signal = left_square
    elsif !right_square.nil?
      @color == 'white' ? find_white_en_passant_capture(board, right_square, 'right') : find_black_en_passant_capture(board, right_square, 'right')
      @square_to_signal = right_square
    end
  end

  def find_white_en_passant_capture(board, enemy_square, direction)
    capture_coords = direction == 'left' ? [enemy_square.column, enemy_square.row + 1] : [enemy_square.column, enemy_square.row + 1]
    move = board.squares.select { |square| square.coords == capture_coords }[0]
    @moves.push(move)
  end

  def find_black_en_passant_capture(board, enemy_square, direction)
    capture_coords = direction == 'left' ? [enemy_square.column, enemy_square.row - 1] : [enemy_square.column, enemy_square.row - 1]
    move = board.squares.select { |square| square.coords == capture_coords }[0]
    @moves.push(move)
  end

  def filter_square(square)
    return nil if square.nil?
    return nil if square.piece_on_square.nil?
    return nil unless square.piece_on_square.instance_of? Pawn
    return nil if square.piece_on_square.color == @color
    return nil unless square.piece_on_square.en_passant

    square
  end

  def find_left_square(board)
    board.squares.select { |square| square.coords == [@current_square.column - 1, @current_square.row] }[0]
  end

  def find_right_square(board)
    board.squares.select { |square| square.coords == [@current_square.column + 1, @current_square.row] }[0]
  end

  def en_passant_chosen?(square)
    return false if square.column == @current_square.column
    return false if @square_to_signal.nil?

    true
  end

  def signal_captured_pawn(square)
    capture_move(square)
    square.no_piece
  end
end
