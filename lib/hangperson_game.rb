class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
    
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @letters = Array.new(0)
    @right_letters = Array.new(0)
    @wrong_count = 0
  end
    
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
    
  def guess(guess)
    if (guess.nil?) or guess=="" or (not guess.match? (/\A[a-zA-Z]*\z/))
        raise ArgumentError.new
    end
      
    guess = guess.downcase
    
    if @letters.include? guess
        return false
    end

    if @word.include? guess and 
        @guesses += guess
        @right_letters.push(guess)
    else 
        @wrong_guesses += guess
        @wrong_count = @wrong_count + 1
    end
    @letters.push(guess)
    return true
  end
    
  def word_with_guesses
      displayed = @word
      displayed.chars.each_with_index { |x, index|
         if not @right_letters.include? x
             displayed[index] = "-"
         end
      }
      return displayed
  end
    
  def check_win_or_lose
      if @wrong_count >= 7
          return :lose
      end
      
#       if word_with_guesses.match? (/\A[a-zA-Z]*\z/)
#           return :win
#       elsif word_with_guesses.match? (/\A[---]*\z/)
#           return :lose
#       else
#           return :play
#       end
      if word_with_guesses.include?('-')
        return :play
      else
        return :win
      end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end
