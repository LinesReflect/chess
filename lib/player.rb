# frozen_string_literal: true

class Player
  attr_reader :number, :name, :color, :pieces_in_play, :pieces_with_moves

  def initialize(number)
    @number = number
    @name = nil
    @color = nil
    @pieces_in_play = []
    @pieces_with_moves = []
  end

  def player_name(opponent_name = nil)
    loop do
      puts player_greeting
      input = gets.chomp
      return @name = input if valid_name?(input, opponent_name)
    end
  end

  def player_greeting()
    "Player #{@number}, please enter a unique name at least 3 characters long!"
  end

  def valid_name?(name, opponent_name = nil)
    return false if name.length < 3 || name == opponent_name

    true
  end

  def choose_player_color(opponent_color = nil)
    return @color = opponent_color == 'white' ? 'black' : 'white' unless opponent_color.nil?

    loop do 
      puts "#{@name}, press 1 to use white pieces or 2 for black pieces."
      input = gets.chomp.to_i
      redo unless [1, 2].include?(input)
      return @color = input == 1 ? 'white' : 'black'
    end
  end

  def add_piece(piece)
    @pieces.push(piece)
  end
end
