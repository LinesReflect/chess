# frozen_string_literal: true

require_relative 'game'

def new_or_load_game
  puts 'Would you like to load a game? Y/N'
  input = yes_no_input
  yes?(input) ? Game.new.load_game_setup : Game.new.new_game_setup
end

def yes_no_input
  loop do
    input = gets.chomp
    return input if valid_input?(input)

    puts "Not a valid input. Enter 'Y' for yes and 'N' for no."
  end
end

def valid_input?(input)
  return true if ['Y','N'].include?(input)

  false
end

def yes?(input)
  return true if input == 'Y'

  false
end

new_or_load_game
