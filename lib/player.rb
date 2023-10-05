# frozen_string_literal: true

class Player
  attr_reader :number, :name, :color, :pieces_in_play, :pieces_with_moves, :pieces_with_check_breaking_moves, :all_moves

  def initialize(number)
    @number = number
    @name = nil
    @color = nil
    @pieces_in_play = []
    @pinned_pieces = []
    @pieces_with_moves = []
    @pieces_with_check_breaking_moves = []
    @all_moves = []
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

  def possible_moves(board, enemy_moves = nil)
    @pieces_with_moves.clear
    @pieces_in_play.each do |piece|
      next if @pinned_pieces.include?(piece)

      piece.piece_name == 'King' ? piece.find_moves(piece.current_square, board, enemy_moves) : piece.find_moves(piece.current_square, board)
      next if piece.moves.empty?

      @pieces_with_moves.push(piece)
    end
    add_all_moves
  end

  def find_pinned_pieces(board, enemy, checking_piece = nil)
    @pinned_pieces.clear
    @pieces_in_play.map do |piece|
      piece.current_square_remove_piece
      enemy.possible_moves(board)
      enemy_moves = checking_piece.nil? ? enemy.all_moves : enemy.all_moves - checking_piece.moves
      @pinned_pieces.push(piece) if piece.pinned?(enemy_moves)
      piece.claim_square
    end
  end

  def add_all_moves
    @all_moves = []
    @pieces_with_moves.map { |piece| piece.moves.map { |move| @all_moves.push(move)}}
  end

  def find_check_removers(board)
    possible_moves(board)
    @pieces_with_moves.map do |piece|
      @check_moves.push(piece) if piece.can_check?
    end
  end

  def find_check_breakers(board, enemy, enemy_piece, enemy_moves)
    enemy.possible_moves(board)
    possible_moves(board, enemy_moves)
    @pieces_with_moves.map do |piece|
      new_moves = []
      piece.moves.map do |move|
        new_moves.push(move) if move.piece_on_square == enemy_piece
        next if move.piece_on_square == enemy_piece
        original_square = piece.current_square
        piece.change_square(move)
        enemy.possible_moves(board)
        new_moves.push(move) unless getting_checked?(enemy.all_moves)
        piece.change_square(original_square)
      end
      piece.refresh_possible_moves(new_moves)
    end
    @pieces_with_moves.reject! { |piece| piece.moves.empty? }
  end

  def print_moves(moves_array)
    i = 0
    while i < moves_array.length
      print "#{i + 1}. #{moves_array[i].piece_name}(#{moves_array[i].current_square.rank_and_file})"
      i == moves_array.length - 1 ? print("\n") : print(' ')
      i += 1
    end
  end

  def print_pieces_in_play
    puts "#{@pieces_in_play.map { |piece| [piece.symbol, piece.current_square.coords]}}"
  end

  def getting_checked?(enemy_moves)
    return true if enemy_moves.any? { |move| move.piece_on_square.instance_of?(King)}

    false
  end

  def checking_enemy?
    return true if @all_moves.any? { |move| move.piece_on_square.instance_of?(King)}

    false
  end

  def remove_piece_from_play(piece, enemy_player)
    enemy_player.pieces_in_play.delete(piece)
  end

  def captured_piece(piece, enemy_player)
    remove_piece_from_play(piece, enemy_player)
    @captured_pieces.push(piece)
  end

  def rooks_for_castle
    rook_arr = @pieces_in_play.select { |piece| piece.piece_name == 'Rook' }
    rook_arr.reject! { |rook| rook.first_move == false }
    rook_arr.reject! { |rook| rook.moves.none? { |move| move.column == 4 || move.column == 6}}
  end

  def player_pawns
    @pieces_in_play.select { |piece| piece.instance_of? Pawn}
  end
end
