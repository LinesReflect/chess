# frozen_string_literal: true

require 'json'
require 'date'

module SaveLoad
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
        end
      end
    end
  end

  def filename
    puts 'Enter a name for your game file'
    format_filename(gets.chomp).concat(current_date_time)
  end

  def format_filename(name)
    name.gsub!(/[!:*?"<>|]/, '_')
    name.gsub!("/", '_')
  end

  def current_date_time
    right_now = DateTime.now
    right_now.strftime("(%D)[%I.%M%p]").gsub!("/", '-')
  end
end
