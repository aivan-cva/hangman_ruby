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



  def play
    secret_arr = @secret.split('')
    display_secret = secret_display(secret)

    while tries > 0
      puts "Tries left: #{tries}"
      puts display_secret.join(' ')

      puts "Type one character:"
      guess = gets.chomp.strip.downcase

      @guesses << guess.upcase
      p "Guesses: #{@guesses.join('')}"

      secret_arr.each_with_index do |el, i|
        if el == guess
          display_secret[i] = el
        end
      end

      unless display_secret.include?('_')
        p "You win!"
        return
      end


      @tries -= 1
      p "You loose, the secret word was: #{@secret}" if tries == 0
    end

  end




  def to_s
    " #{@secret}"
  end
end


x = Game.new()
x.play
