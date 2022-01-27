require 'colorize'

# numbers = [
#   "#{'  1  '.colorize(:color => :black, :background => :red)}",
#   "#{'  2  '.colorize(:color => :black, :background => :yellow)}",
#   "#{'  3  '.colorize(:color => :black, :background => :green)}",
#   "#{'  4  '.colorize(:color => :black, :background => :blue)}",
#   "#{'  5  '.colorize(:color => :black, :background => :magenta)}",
#   "#{'  6  '.colorize(:color => :black, :background => :cyan)}"
# ]

# clue_symbols = {
#   correct_spot: "\u2605".colorize(:green),
#   incorrect_spot: "\u25CF".colorize(:yellow),
#   incorrect_number: "\u2613".colorize(:red)
# }

# welcome_message = 
#   "Welcome to Mastermind!\n\n"\
#   "Mastermind is a code-breaking game that you will play against the computer.\n"\
#   "Read on to learn the rules and play a game!\n\n"

# puts welcome_message

# instruction_message =
#   "#{'How to Play Mastermind'.underline}:\n\n"\
#   "Here, Mastermind is a 1-player terminal-based game in which you will play against the computer.\n"\
#   "You are the code-#{'breaker'.underline}. The computer is the code-#{'maker'.underline}.\n\n"\
#   "There are 6 possible numbers (1-6), each with a unique color: \n\n"\
#   "#{numbers[0]}"\
#   "#{numbers[1]}"\
#   "#{numbers[2]}"\
#   "#{numbers[3]}"\
#   "#{numbers[4]}"\
#   "#{numbers[5]}\n\n"\
#   "The coder-maker will generate a 4 digit (color) code using these 6 choices.\n"\
#   "Note: repeated numbers/colors are allowed. For example:\n\n"\
#   "#{'Code'.bold}: "\
#   "#{numbers[0]}"\
#   "#{numbers[4]}"\
#   "#{numbers[0]}"\
#   "#{numbers[2]}\n\n"\
#   "To win the game, the code-breaker must guess the code in, at most, 12 attempts.\n\n"\
#   "After every guess, the code-maker will give clues to help crack the code:\n\n"\
#   "#{"\u2605".colorize(:green)} This clue corresponds to a number in the correct spot\n"\
#   "#{"\u25CF".colorize(:yellow)} This clue corresponds to a number in the code but in an incorrect spot\n"\
#   "#{"\u2613".colorize(:red)} This clue corresponds to a number that is #{"not".underline} in the code.\n\n"\
#   "For example, using the above code, the following guess would generate this clue:\n\n"\
#   "Guess: "\
#   "#{'  1  '.colorize(:color =>:black, :background => :red)}"\
#   "#{'  1  '.colorize(:color =>:black, :background => :red)}"\
#   "#{'  5  '.colorize(:color =>:black, :background => :magenta)}"\
#   "#{'  4  '.colorize(:color =>:black, :background => :blue)}\n\n"\
#   "Clue: #{clue_symbols[:correct_spot]} #{clue_symbols[:incorrect_spot]} #{clue_symbols[:incorrect_spot]} #{clue_symbols[:incorrect_number]}"



# puts instruction_message

class MastermindGame
  attr_accessor :attempts_remaining, :code, :code_setter, :code_breaker

  def initialize(code) 
    self.attempts_remaining = 12
    self.code = code
  end

  def decrement_attempts_remaining
    self.attempts_remaining -= 1
  end

  def correct_guess?(guess)
    guess == self.code
  end

  def game_over?(guess)
    self.attempts_remaining <= 0 || correct_guess?(guess)
  end
end  

class CodeSetter
  attr_accessor :code
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
  code_setter = CodeSetter.new
  code_breaker = CodeBreaker.new
  game = MastermindGame.new(code_setter.set_random_code)
  game.code_setter = code_setter
  game.code_breaker = code_breaker

  guess = code_breaker.guess_code
  game.decrement_attempts_remaining
  until game.game_over?(guess)
    puts "Sorry, that is not the code!"
    puts "You have #{game.attempts_remaining} attempts left."
    guess = code_breaker.guess_code
    game.decrement_attempts_remaining
  end
  if game.correct_guess?(guess)
    puts "Congratulations! You guessed the code!"
  else
    puts "Sorry, you lost! The correct code was #{game.code.join("")}"
  end
end

play_game




