# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require 'colorize'

class Game
  attr_reader :board

  def initialize(player_1 = Player.new, player_2 = Player.new, board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
end
