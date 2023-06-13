# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'piece_creator'
require 'colorize'

class Game
  include PieceCreator
  attr_reader :board

  def initialize(player1 = Player.new(1), player2 = Player.new(2), board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @player_turn = nil
  end

  def game_setup
    game_greeting
    player_names
    player_colors
    puts "#{@player1.name} will control #{@player1.color} pieces and #{@player2.name} controls the #{@player2.color} pieces."
    create_pieces
    @board.display_board
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
end
