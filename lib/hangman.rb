require './game'
require "tty-prompt"
require 'yaml'

class Hangman
  def initialize

  end

  def load_game(name)
    yaml_data = File.read("../save_files/#{name}")
    loaded_data = YAML.load(yaml_data)
    puts "LOADED DATA:"
    puts loaded_data

    continue_game = Game.new(loaded_data[:secret], loaded_data[:tries],loaded_data[:guesses])

    continue_game.play
  end

  def new_word
    word = File.readlines('../words_5_12.txt').sample.chomp.strip
  end

  def run
    prompt = TTY::Prompt.new
    choice = prompt.select("Play a new game or load a save file:",['New Game','Load Game'])

    if choice == 'New Game'
      new_game = Game.new(new_word)
      new_game.play()
    end

    if choice == 'Load Game'
      dir_path = '../save_files'
      file_names = Dir.entries(dir_path).select { |file| File.file?(File.join(dir_path,file))}


      game_to_load = prompt.select("Select a save file:", file_names)
      load_game(game_to_load)
    else

    end

  end
end


h = Hangman.new
h.run
