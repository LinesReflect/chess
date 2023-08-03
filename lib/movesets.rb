# frozen_string_literal: true

require_relative 'piece'
require_relative 'board'
require_relative 'square'

module Movesets
  def knight_move_coords
    [
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1],
    [-1, 2]
    ]
  end

  def up_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column + 1, current_square.row]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def down_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column - 1, current_square.row]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def right_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column, current_square.row + 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def left_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column, current_square.row - 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def up_right_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column + 1, current_square.row + 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def up_left_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column + 1, current_square.row - 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def down_right_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column - 1, current_square.row + 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def down_left_moves(current_square, board, king = false)
    loop do
      current_square = board.squares.select { |square| square.coords == [current_square.column - 1, current_square.row - 1]}
      current_square = current_square[0]
      return if current_square.nil?
      return if !current_square.piece_on_square.nil? && current_square.piece_on_square.player == @player

      @moves.push(current_square)
      return unless current_square.piece_on_square.nil?
      return if king
    end
  end

  def white_pawn_moves(current_square, board)
    if current_square.row == 2
      move = board.squares.select { |square| square.coords == [current_square.column, 4] }
      @moves.push(move[0])
    end
    move = board.squares.select { |square| square.coords == [current_square.column, current_square.row + 1] }
    @moves.push(move[0])
  end

  def black_pawn_moves(current_square, board)
    if current_square.row == 7
      move = board.squares.select { |square| square.coords == [current_square.column, 5] }
      @moves.push(move[0])
    end
    move = board.squares.select { |square| square.coords == [current_square.column, current_square.row - 1] }
    @moves.push(move[0])
  end

  def knight_moves(start_square, board)
    i = 0
    while i < 8
      current_square = board.squares.select { |square| square.coords == [start_square.coords, knight_move_coords[i]].transpose.map { |num| num.inject(:+)}}[0]
      if !current_square.nil? && current_square.piece_on_square.nil?
        @moves.push(current_square)
      elsif !current_square.nil? && !current_square.piece_on_square.nil?
        @moves.push(current_square) unless current_square.piece_on_square.player == start_square.piece_on_square.player
      end
      i += 1
    end
  end
end
