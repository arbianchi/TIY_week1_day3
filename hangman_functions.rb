require "pry"

play = true

def populate_dict db
  f = File.open(db)
  dict = []
  f.each_line {|line| dict.push line.chomp}
  return dict
end

def filter_dict db
  words = (populate_dict db).select { |x| x.length > 3 && x.length < 6}
  return words
end

def choose_word words
  words.sample.split("")
end

def print_board guessbox
  puts
  guessbox.each do |i|
    print i
  end
  puts
end

def get_guess
  print "Guess a letter: "
  entry = gets.chomp
  return entry
end

def invalid_entry guess
  if guess.to_i.to_s == guess || guess.length > 1

    print "Enter one letter you haven't guess yet!\n"
    invalid = true
    return invalid
  end
end

def repeat_entry guess, prevguess
  if prevguess.include? guess

    puts "You already guess that!"
    invalid = true
    return invalid
  end
end

def valid_entry splitword, guess, guessbox
  index = 0
  splitword.each do |i|
    if i == guess
      guessbox[index] = guess
    end
    index += 1
  end
end

def display_correct splitword, guessbox, guess


  index = 0
  splitword.each do |i|
    if i == guess
      guessbox[index] = guess
    end
    index += 1
  end

end

def outcome splitword, guessbox
  if splitword == guessbox
    puts "You win!"
    return
  else
    puts "You lose!"" The word was #{splitword.join.upcase}.\n"
    return
  end
end

def play_again
  play = true
  puts "Play again? Enter 'y' for yes or 'q' for quit\n"
  again = gets.chomp.downcase
  if again == 'q'
    play = false
    return
  end
end

while play

  puts "Welcome to Hangman"

  splitword = choose_word filter_dict "dictwords.txt"

  # Creates empty answer array
  guessbox = Array.new(splitword.length, " _ ")
  # Empty array for previous guesses
  prevguess = []

  guesses = 2

  print_board guessbox

  until guesses == 0 || guessbox.include?(" _ ") == false do

    unknownleft = guessbox.count " _ "

    guess = get_guess

    if guess.to_i.to_s == guess || guess.length > 1

      print "Invalid entry.\n"

    elsif prevguess.include? guess

      puts "You already guess that!"

    else
      index = 0
      splitword.each do |i|
        if i == guess
          guessbox[index] = guess
        end
        index += 1

      end

      # Decrement guess counter
      guesses -= 1 unless (guessbox.count " _ ").to_i < unknownleft.to_i

      print_board guessbox

      prevguess.push(guess)
      # Prints previous guesses
      print "Previous Guesses:\n"
      prevguess.each do |l|
        print  " " + l + " "
      end
      puts

      # Prints remaining guesses
      print "Guesses left: #{guesses}\n"

    end
  end

  outcome splitword, guessbox

  play_again

  end
end
