class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if not letter=~/[a-zA-Z]/

    letter = letter.downcase

    if @word.include?(letter)
      if @guesses.include?(letter) then false else @guesses << letter end
    else
      if @wrong_guesses.include?(letter) then false else @wrong_guesses << letter end
    end

  end

  def word_with_guesses
    @word.chars.map{|x| if @guesses.include?(x) then x else '-' end}.join
  end

  def check_win_or_lose
    if (@guesses+@wrong_guesses).length < 7 
      if @word.chars.uniq.sort == @guesses.chars.sort
        return :win
      else
        return :play
      end
    else
      return :lose
    end
  end

end
