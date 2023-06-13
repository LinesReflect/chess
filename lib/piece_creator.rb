# frozen_string_literal: true

require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

module PieceCreator
  def create_pieces(player)
    create_pawns(player)
    create_rooks(player)
    create_kinghts(player)
    create_bishops(player)
    create_queens(player)
    create_kings(player)
  end

  def create_pawns(player)
    current_square = player.color == 'white' ? 8 : 48
    i = 1
    while i < 9
      piece = Pawn.new(player, player.color, @board.squares[current_square]).claim_square
      player.add_piece(piece)
      current_square += 1
      i += 1
    end
  end

  def create_rooks(player)
    current_square = player.color == 'white' ? 0 : 56
    i = 1
    while i < 3
      piece = Rook.new(player, player.color, @board.squares[current_square]).claim_square
      current_square += 7
      player.add_piece(piece)
      i += 1
    end
  end

  def create_kinghts(player)
    current_square = player.color == 'white' ? 1 : 57
    i = 1
    while i < 3
      piece = Knight.new(player, player.color, @board.squares[current_square]).claim_square
      player.add_piece(piece)
      current_square += 5
      i += 1
    end
  end

  def create_bishops(player)
    current_square = player.color == 'white' ? 2 : 58
    i = 1
    while i < 3
      piece = Bishop.new(player, player.color, @board.squares[current_square]).claim_square
      player.add_piece(piece)
      current_square += 3
      i += 1
    end
  end

  def create_queens(player)
    current_square = player.color == 'white' ? 3 : 59
    piece = Queen.new(player, player.color, @board.squares[current_square]).claim_square
    player.add_piece(piece)
  end

  def create_kings(player)
    current_square = player.color == 'white' ? 4 : 60
    piece = King.new(player, player.color, @board.squares[current_square]).claim_square
    player.add_piece(piece)
  end
end
