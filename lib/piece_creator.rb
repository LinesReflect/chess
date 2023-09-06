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
    current_square, fen = player.color == 'white' ? [8, 'P'] : [48, 'p']
    i = 1
    while i < 9
      piece = Pawn.new('Pawn', player, player.color, @board.squares[current_square], fen).claim_square
      player.add_piece(piece)
      current_square += 1
      i += 1
    end
  end

  def create_rooks(player)
    current_square, fen = player.color == 'white' ? [0, 'R'] : [56, 'r']
    i = 1
    while i < 3
      piece = Rook.new('Rook', player, player.color, @board.squares[current_square], fen).claim_square
      player.add_piece(piece)
      current_square += 7
      i += 1
    end
  end

  def create_kinghts(player)
    current_square, fen = player.color == 'white' ? [1, 'N'] : [57, 'n']
    i = 1
    while i < 3
      piece = Knight.new('Knight', player, player.color, @board.squares[current_square], fen).claim_square
      player.add_piece(piece)
      current_square += 5
      i += 1
    end
  end

  def create_bishops(player)
    current_square, fen = player.color == 'white' ? [2, 'B'] : [58, 'b']
    i = 1
    while i < 3
      piece = Bishop.new('Bishop', player, player.color, @board.squares[current_square], fen).claim_square
      player.add_piece(piece)
      current_square += 3
      i += 1
    end
  end

  def create_queens(player)
    current_square, fen = player.color == 'white' ? [3, 'Q'] : [59, 'q']
    piece = Queen.new('Queen', player, player.color, @board.squares[current_square], fen).claim_square
    player.add_piece(piece)
  end

  def create_kings(player)
    current_square, fen = player.color == 'white' ? [4, 'K'] : [60, 'k']
    piece = King.new('King', player, player.color, @board.squares[current_square], fen).claim_square
    player.add_piece(piece)
  end
end
