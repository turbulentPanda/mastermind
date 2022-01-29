module Clueable
  require 'colorize'

  NUMBERS = [
    "#{'  1  '.colorize(:color => :black, :background => :red)}",
    "#{'  2  '.colorize(:color => :black, :background => :yellow)}",
    "#{'  3  '.colorize(:color => :black, :background => :green)}",
    "#{'  4  '.colorize(:color => :black, :background => :blue)}",
    "#{'  5  '.colorize(:color => :black, :background => :magenta)}",
    "#{'  6  '.colorize(:color => :black, :background => :cyan)}"
  ]

  CLUE_SYMBOLS = {
    correct_spot: " #{"\u2605".colorize(:green)}",
    incorrect_spot: " #{"\u25CF".colorize(:yellow)}",
    incorrect_number: " #{"\u2613".colorize(:red)}"
  }
end

welcome_message = 
  "Welcome to Mastermind!\n\n"\
  "Mastermind is a code-breaking game that you will play against the computer.\n"\
  "Read on to learn the rules and play a game!\n\n"

# puts welcome_message

instruction_message =
  "#{'How to Play Mastermind'.underline}:\n\n"\
  "Here, Mastermind is a 1-player terminal-based game in which you will play against the computer.\n"\
  "You are the code-#{'breaker'.underline}. The computer is the code-#{'maker'.underline}.\n\n"\
  "There are 6 possible numbers (1-6), each with a unique color: \n\n"\
  "#{Clueable::NUMBERS[0]}"\
  "#{Clueable::NUMBERS[1]}"\
  "#{Clueable::NUMBERS[2]}"\
  "#{Clueable::NUMBERS[3]}"\
  "#{Clueable::NUMBERS[4]}"\
  "#{Clueable::NUMBERS[5]}\n\n"\
  "The coder-maker will generate a 4 digit (color) code using these 6 choices.\n"\
  "Note: repeated numbers/colors are allowed. For example:\n\n"\
  "#{'Code'.bold}: "\
  "#{Clueable::NUMBERS[0]}"\
  "#{Clueable::NUMBERS[4]}"\
  "#{Clueable::NUMBERS[0]}"\
  "#{Clueable::NUMBERS[2]}\n\n"\
  "To win the game, the code-breaker must guess the code in, at most, 12 attempts.\n\n"\
  "After every guess, the code-maker will give clues to help crack the code:\n\n"\
  "#{Clueable::CLUE_SYMBOLS[:correct_spot]} This clue corresponds to a number in the correct spot\n"\
  "#{Clueable::CLUE_SYMBOLS[:incorrect_spot]} This clue corresponds to a number in the code but in an incorrect spot\n"\
  "#{Clueable::CLUE_SYMBOLS[:incorrect_number]} This clue corresponds to a number that is #{"not".underline} in the code.\n\n"\
  "For example, using the above code, the following guess would generate this clue:\n\n"\
  "Guess: "\
  "#{Clueable::NUMBERS[0]}"\
  "#{Clueable::NUMBERS[0]}"\
  "#{Clueable::NUMBERS[4]}"\
  "#{Clueable::NUMBERS[3]}\n\n"\
  "Clue: #{Clueable::CLUE_SYMBOLS[:correct_spot]} #{Clueable::CLUE_SYMBOLS[:incorrect_spot]} #{Clueable::CLUE_SYMBOLS[:incorrect_spot]} #{Clueable::CLUE_SYMBOLS[:incorrect_number]}"

# puts instruction_message

class MastermindGame
  attr_accessor :attempts_remaining, :code, :code_setter, :code_breaker

  def initialize() 
    self.attempts_remaining = 12
  end

  def decrement_attempts_remaining
    self.attempts_remaining -= 1
  end

  def play_one_turn
    self.decrement_attempts_remaining
    guess = code_breaker.guess_code
  end

  def correct_guess?(guess)
    guess == self.code
  end

  def game_over?(guess)
    self.attempts_remaining <= 0 || correct_guess?(guess)
  end

  def play_entire_game
    guess = self.play_one_turn
    until self.game_over?(guess)
      puts "Sorry, that is not the code!"
      puts "You have #{self.attempts_remaining} attempts left."
      guess = self.play_one_turn
    end
    guess
  end

  def display_game_results(guess)
    if self.correct_guess?(guess)
      return "Congratulations! You guessed the code!"
    else
      return "Sorry, you lost! The correct code was #{self.code.join("")}"
    end
  end

end  

class CodeSetter
  attr_accessor :code
  include Clueable

  def initialize
  end

  def generate_random_number_string(num)
    rand(num + 1).to_s
  end

  def set_random_code
    self.code = [
      generate_random_number_string(7),
      generate_random_number_string(7),
      generate_random_number_string(7),
      generate_random_number_string(7)
    ]
  end

  def give_clue(code, guess)
    clue = guess.split("").map.with_index do |digit, index|
      if digit == code[index]
        CLUE_SYMBOLS[:correct_spot]
      elsif code.include?(digit)
        CLUE_SYMBOLS[:incorrect_spot]
      else
        CLUE_SYMBOLS[:incorrect_number]
      end
    end
    clue.join("")
  end
end

class CodeBreaker
  def initialize
  end

  def valid_code_length?(code)
    code.length == 4
  end

  def valid_code_numbers?(code)
    code.split("").all? { |num| "123456".include?(num)}
  end

  def valid_code?(code)
    valid_code_length?(code) && valid_code_numbers?(code)
  end

  def guess_code
    puts "Please enter your guess: "
    guess = gets.chomp
    until valid_code?(guess)
      puts "Your guess must be 4 digits long and only contain digits 1-6. Please enter a new one: "
      guess = gets.chomp
    end
    guess
  end

end

def play_game
  game = MastermindGame.new
  game.code_setter = CodeSetter.new
  game.code_breaker = CodeBreaker.new
  game.code = game.code_setter.set_random_code
  puts game.display_game_results(game.play_entire_game)
end

# play_game