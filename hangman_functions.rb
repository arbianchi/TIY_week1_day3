require "pry"

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

def print_board
  puts
  guessbox.each do |i|
    print i
  end
  puts
end



play = true

while play

  puts "Welcome to Hangman"

  splitword = choose_word filter_dict "dictwords.txt"

  # Creates empty answer array
  guessbox = Array.new(splitword.length, " _ ")

  # Empty array for previous guesses
  prevguess = []

  guesses = 6

  until guesses == 0 || guessbox.include?(" _ ") == false do

    print "Guess a letter: "
    guess = gets.chomp
    unknownleft = guessbox.count " _ "

    if guess.to_i.to_s == guess || guess.length > 1

      print "Enter one letter you haven't guess yet!\n"

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



      # Print board
      puts
      guessbox.each do |i|
        print i
      end
      puts

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

  if splitword == guessbox
    puts "You win!"
  else
    puts "You lose!"" The word was #{splitword.join.upcase}.\n"
    end
  puts "Play again? Enter 'y' for yes or 'q' for quit\n"
  again = gets.chomp.downcase
    if again == 'q'
      play = false
    else again != 'y'
      print "Enter 'y' to play again or 'q' for quit\n"
    end
  end
