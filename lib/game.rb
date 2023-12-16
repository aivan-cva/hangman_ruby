require 'yaml'

class Game
  def initialize(secret='hello', tries=12, guesses=[])
    @secret = secret
    @tries = tries
    @guesses = guesses
  end
  attr_accessor :guesses, :tries, :secret

  def secret_display(code)
    len = code.length
    disp = Array.new(len).fill('_')
  end

  def save_game(name)
    data = {
      secret: @secret,
      tries: @tries,
      guesses: @guesses
    }

    yaml_data = YAML.dump(data)

    File.open("../save_files/#{name}.yaml",'w') { |file| file.write(yaml_data)}
  end

  def load(display, secret_arr)
    puts "Loading guesses"

    @guesses.each_with_index do |guess, guess_i|
      secret_arr.each_with_index do |el,secret_i|
        if guess.downcase == el
          display[secret_i] = guess.downcase
        end
      end
    end
  end


  def play
    secret_arr = @secret.split('')
    display_secret = secret_display(secret)
    load(display_secret, secret_arr)

    while tries > 0
      puts "Tries left: #{tries}"
      puts display_secret.join(' ')

      puts "Type one character or type save to save the game:"
      guess = gets.chomp.strip.downcase

      if guess == 'save'
        puts "Enter save file name"
        save_name = gets.chomp.strip
        save_game(save_name)
        return
      end

      while guess.length > 1 or guess.length < 1
        p "Input Error: Type one character"
        guess = gets.chomp.strip.downcase
      end


      @guesses << guess.upcase
      p "Guesses: #{@guesses.join('')}"

      secret_arr.each_with_index do |el, i|
        if el == guess
          display_secret[i] = el
        end
      end

      unless display_secret.include?('_')
        p "You win! the secret word is: #{display_secret.join('').upcase}"
        return
      end


      @tries -= 1
      p "You loose, the secret word was: #{@secret.upcase}" if tries == 0
    end

  end

  def to_s
    "Secret: #{@secret}
     Tries: #{@tries}
     Guesses: #{@guesses}"
  end
end
