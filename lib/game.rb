# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'piece_creator'
require_relative 'king'
require 'colorize'
require_relative 'save_load'

class Game
  attr_reader :board, :player1, :player2, :player_turn, :enemy_player, :turn_number, :check

  include PieceCreator
  include SaveLoad

  def initialize(player1 = Player.new(1), player2 = Player.new(2), board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_turn = nil
    @enemy_player = nil
    @turn_number = 1
    @check = false
  end

  def new_game_setup
    game_greeting
    player_names
    player_colors
    puts "#{@player1.name} will control #{@player1.color} pieces and #{@player2.name} controls the #{@player2.color} pieces."
    create_pieces(@player1)
    create_pieces(@player2)
    run_game
  end

  def load_game_setup
    return no_saved_games unless saved_files_arr

    restore_game_data(load_game)
    puts 'Welcome back!'
    display_turn_info
    @board.display_board
    in_check?(@enemy_player.all_moves) ? remove_check_move : normal_move
    reset_en_passant
    run_game
  end

  def run_game
    loop do
      change_turn
      display_turn_info
      @board.display_board
      find_enemy_moves
      in_check?(@enemy_player.all_moves) ? remove_check_move : normal_move
      break if checkmate?
      reset_en_passant
    end
    puts "Checkmate"
    puts "#{@enemy_player} WINS!"
  end

  def normal_move
    @player_turn.find_pinned_pieces(@board, @enemy_player)
    @player_turn.possible_moves(@board, find_enemy_moves)
    player_move_piece
  end

  def remove_check_move
    puts 'Check'
    @check = true
    @player_turn.find_pinned_pieces(@board, @enemy_player, check_piece)
    player_check_breakers
    return if empty_moves?

    player_move_piece
    @check = false
  end

  def player_move_piece
    puts choose_piece_to_move
    @player_turn.print_moves(@player_turn.pieces_with_moves)
    moving_piece = @player_turn.pieces_with_moves[user_input]
    @board.display_board(moving_piece.moves)
    moving_piece.print_moves
    puts choose_where_to_move
    new_square = moving_piece.moves[user_input]
    moving_piece.change_square(new_square, @board)
  end

  def display_turn_info
    puts "Turn ##{@turn_number}"
    puts "#{@player_turn.name}'s turn!"
  end

  def checkmate?
    return true if @check

    false
  end

  def in_check?(enemy_moves)
    return true if @player_turn.getting_checked?(enemy_moves)

    false
  end

  def empty_moves?
    return true if @player_turn.pieces_with_moves.empty?

    false
  end

  def player_check_breakers
    @player_turn.find_check_breakers(@board, @enemy_player, check_piece, find_enemy_moves)
  end

  def check_piece
    @enemy_player.pieces_with_moves.select { |piece| piece.checking_enemy_king? }[0]
  end

  def user_input
    loop do
      input = gets.chomp
      return input.to_i - 1 if valid_number_input?(input.to_i, @player_turn)

      if input == 'SAVE'
        save_game
        puts choose_piece_to_move
        @player_turn.print_moves(@player_turn.pieces_with_moves)
      else
        puts 'Not a valid input. Enter an approriate number e.g 1, 2, 3.'
      end
    end
  end

  def valid_number_input?(number, player)
    return true if (1..player.pieces_in_play.length).include?(number)

    false
  end

  def change_turn
    @player_turn = @player1.color == 'white' ? @player1 : @player2 if @player_turn.nil?
    return @enemy_player = @player_turn == @player1 ? @player2 : @player1 if @enemy_player.nil?

    @player_turn = @player_turn == @player1 ? @player2 : @player1
    @enemy_player = @player_turn == @player1 ? @player2 : @player1
    @turn_number += 1
  end

  def find_enemy_moves
    @turn_number == 1 ? @enemy_player.possible_moves(@board) : @enemy_player.possible_moves(@board)
    @enemy_player.all_moves
  end

  def no_saved_games
    puts 'Looks like you do not have any saved games. How about we start a new one.'
    Game.new.new_game_setup
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
    "#{@player_turn.name}, please type the number of the piece that you want to move, or type 'SAVE' to save the game."
  end

  def choose_where_to_move
    'Type the number of the square that you want to move to. '
  end

  def reset_en_passant
    @enemy_player.player_pawns.map do |pawn|
      pawn.remove_en_passant
    end
  end
end
