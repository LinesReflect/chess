# frozen_string_literal: true

class Player
  attr_reader :number, :name, :color, :pieces_in_play, :pieces_with_moves

  def initialize(number)
    @number = number
    @name = nil
    @color = nil
    @pieces_in_play = []
    @pieces_with_moves = []
    @captured_pieces = []
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
      puts "#{@name}, press 1 to use white(solid) pieces or 2 for black(clear) pieces."
      input = gets.chomp.to_i
      redo unless [1, 2].include?(input)
      return @color = input == 1 ? 'white' : 'black'
    end
  end

  def add_piece(piece)
    @pieces_in_play.push(piece)
  end

  def possible_moves(board)
    @pieces_with_moves = []
    @pieces_in_play.each do |piece|
      piece.find_moves(piece.current_square, board)
      next if piece.moves.empty?
      @pieces_with_moves.push(piece)
    end
  end

  def print_moves
    i = 0
    while i < @pieces_with_moves.length
      print "#{i + 1}.#{pieces_with_moves[i].current_square.rank_and_file}"
      i == @pieces_with_moves.length - 1 ? print("\n") : print(' ')
      i += 1
    end
  end

  def captured_piece(piece)
    @captured_pieces.push(piece)
  end
end
