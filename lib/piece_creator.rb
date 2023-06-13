# frozen_string_literal: true

require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

module PieceCreator
  def create_pieces
    create_pawns
    create_rooks
    create_kinghts
    create_bishops
    create_queens
    create_kings
  end

  def create_pawns
    player = @player1.color == 'white' ? @player1 : @player2
    i = 1
    current_white = 8
    current_black = 48
    while i < 17
      if i < 9
        Pawn.new(player, player.color, @board.squares[current_white]).claim_square
        current_white += 1
      else
        player = @player1 ? @player2 : @player1
        Pawn.new(player, player.color, @board.squares[current_black]).claim_square
        current_black += 1
      end
      i += 1
    end
  end

  def create_rooks
    player = @player1.color == 'white' ? @player1 : @player2
    i = 1
    current_white = 0
    current_black = 56
    while i < 5
      if i < 3
        Rook.new(player, player.color, @board.squares[current_white]).claim_square
        current_white += 7
      else
        player = @player1 ? @player2 : @player1
        Rook.new(player, player.color, @board.squares[current_black]).claim_square
        current_black += 7
      end
      i += 1
    end
  end

  def create_kinghts
    player = @player1.color == 'white' ? @player1 : @player2
    i = 1
    current_white = 1
    current_black = 57
    while i < 5
      if i < 3
        Knight.new(player, player.color, @board.squares[current_white]).claim_square
        current_white += 5
      else
        player = @player1 ? @player2 : @player1
        Knight.new(player, player.color, @board.squares[current_black]).claim_square
        current_black += 5
      end
      i += 1
    end
  end

  def create_bishops
    player = @player1.color == 'white' ? @player1 : @player2
    i = 1
    current_white = 2
    current_black = 58
    while i < 5
      if i < 3
        Bishop.new(player, player.color, @board.squares[current_white]).claim_square
        current_white += 3
      else
        player = @player1 ? @player2 : @player1
        Bishop.new(player, player.color, @board.squares[current_black]).claim_square
        current_black += 3
      end
      i += 1
    end
  end

  def create_queens
    player = @player1.color == 'white' ? @player1 : @player2
    Queen.new(player, player.color, @board.squares[3]).claim_square
    player = @player1 ? @player2 : @player1
    Queen.new(player, player.color, @board.squares[59]).claim_square
  end

  def create_kings
    player = @player1.color == 'white' ? @player1 : @player2
    King.new(player, player.color, @board.squares[4]).claim_square
    player = @player1 ? @player2 : @player1
    King.new(player, player.color, @board.squares[60]).claim_square
  end
end
