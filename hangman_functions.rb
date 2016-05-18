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
def is_invalid guess, prevguess
  if guess.to_i.to_s == guess || guess.length > 1

    print "Invalid entry.\n"
    return true
  elsif prevguess.include? guess

    puts "You already guess that!"
    return true
  else
    return false
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
def show_previous_guesses prevguess, guess
  prevguess.push(guess)
  # Prints previous guesses
  print "Previous Guesses:\n"
  prevguess.each do |l|
    print  " " + l + " "
  end
  puts
end
def decrement_attempts guesses, guessbox, unknownleft
  guesses -= 1 unless (guessbox.count " _ ").to_i < unknownleft.to_i
  print "Guesses left: #{guesses}\n"
  return guesses
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
  puts "Play again? Enter 'y' for yes or 'q' for quit\n"
  again = gets.chomp.downcase
  if again == 'q'
    return false
  else
    return true
  end
end
while play

  puts "Welcome to Hangman"

  splitword = choose_word filter_dict "dictwords.txt"
  guessbox = Array.new(splitword.length, " _ ")
  prevguess = []
  guesses = 5
  print_board guessbox

  until guesses == 0 || guessbox.include?(" _ ") == false do

    unknownleft = guessbox.count " _ "
    guess = get_guess

    unless is_invalid guess, prevguess

      valid_entry splitword, guess, guessbox
      guesses = decrement_attempts guesses, guessbox, unknownleft
      print_board guessbox
      show_previous_guesses prevguess, guess

    end
  end

  outcome splitword, guessbox
  play = play_again

end
