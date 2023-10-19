# frozen_string_literal: true

require_relative 'game'
require 'yaml'
require 'date'

module SaveLoad
  def save_data
    @data = {}
  end

  def create_folder
    Dir.chdir(Dir.pwd) do
      Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    end
  end

  def save_game
    create_folder
    Dir.chdir(Dir.pwd) do
      Dir.chdir('saved_games') do
        File.open(filename, 'w') do |file|
          YAML.dump(self, file)
        end
      end
    end
  end

  def filename
    puts 'Enter a name for your game file'
    format_filename(gets.chomp).concat(current_date_time).concat('.yml')
  end

  def format_filename(name)
    name.gsub!(/[!:*?"<>|]/, '_')
    name.gsub!("/", '_')
    name.gsub!(' ', '_')
    name
  end

  def current_date_time
    right_now = DateTime.now
    right_now.strftime("(%D)[%I.%M%p]").gsub!("/", '-')
  end

  def load_game
    load_file = nil
    file_num = choose_load - 1
    save_file = saved_files_arr[file_num]
    Dir.chdir(Dir.pwd) do
      puts Dir.children('saved_games')
      Dir.chdir('saved_games') do
        load_file = File.read("#{save_file}")
        YAML.unsafe_load(load_file)
      end
    end
  end

  def restore_game_data(data)
    @player1 = data.player1
    @player2 = data.player2
    @board = data.board
    @player_turn = data.player_turn
    @enemy_player = data.enemy_player
    @turn_number = data.turn_number
    @check = data.check
  end

  def choose_load
    loop do
      saved_files_arr
      puts 'Enter the number of the file that you would like to load.'
      print_saved_files
      num_input = gets.chomp.to_i
      return num_input if valid_file_number?(num_input)

      puts 'Not valid.'
    end
  end

  def saved_files_arr
    file_arr = []
    Dir.chdir(Dir.pwd) do
      return unless Dir.children(Dir.pwd).include?('saved_games')

      Dir.each_child('saved_games') { |file| file_arr.push(file) }
    end
    file_arr
  end

  def print_saved_files
    saved_files_arr.each_with_index { |file, idx| print "#{idx + 1}: '#{file.chomp('.yml')}' " }
    print "\n"
  end

  def valid_file_number?(num)
    return false if saved_files_arr.length < num
    return false if num < 1

    true
  end
end
