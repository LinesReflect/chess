# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'piece_creator'
require 'colorize'

class Game
  attr_reader :board, :player1

  include PieceCreator

  def initialize(player1 = Player.new(1), player2 = Player.new(2), board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_turn = nil
    @turn_number = 1
    @checkmate = false
  end

  def game_setup
    game_greeting
    player_names
    player_colors
    puts "#{@player1.name} will control #{@player1.color} pieces and #{@player2.name} controls the #{@player2.color} pieces."
    create_pieces(@player1)
    create_pieces(@player2)
    run_game
  end

  def run_game
    loop do
      change_turn
      puts @turn_number
      puts "#{@player_turn.name}'s turn!"
      @board.display_board
      player_move_piece
    end
  end

  def player_move_piece
    puts choose_piece_to_move
    @player_turn.possible_moves(@board)
    moving_piece = @player_turn.pieces_with_moves[number_input]
    @board.display_board(moving_piece.moves)
    moving_piece.print_moves
    puts choose_where_to_move
    new_square = moving_piece.moves[number_input]
    moving_piece.change_square(new_square)
  end

  def number_input
    loop do
      number = gets.chomp.to_i
      return number - 1 if valid_number_input?(number, @player_turn)

      puts 'Not a valid input. Just enter an approriate number e.g 1, 2, 3.'
    end
  end

  def valid_number_input?(number, player)
    return true if (1..player.pieces_in_play.length).include?(number)

    false
  end

  def change_turn
    return @player_turn = @player1.color == 'white' ? @player1 : @player2 if @player_turn.nil?

    @player_turn = @player_turn == @player1 ? @player2 : @player1
    @turn_number += 1
  end

  def game_greeting
    puts "Hello players, let's set up the game so we can start!"
  end

  def player_names
    @player1.player_name
    @player2.player_name(@player1.name)
  end

  def player_colors
    @player1.choose_player_color
    @player2.choose_player_color(@player1.color)
  end

  def choose_piece_to_move
    "#{@player_turn.name}, please type the number of the piece that you want to move."
  end

  def choose_where_to_move
    'Type the number of the square that you want to move to. '
  end
end
