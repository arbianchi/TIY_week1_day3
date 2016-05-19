require "pry"


points = {"A"=>1, "B"=>3, "C"=>3, "D"=>2, "E"=>1, "F"=>4, "G"=>2, "H"=>4, "I"=>1, "J"=>8,
  "K"=>5, "L"=>1, "M"=>3, "N"=>1, "O"=>1, "P"=>3, "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
  "U"=>1, "V"=>4, "W"=>4, "X"=>8, "Y"=>4, "Z"=>10}


  player1 = {"Score" => 0, "Total" => 0, "Max" => 0}
  player2= {"Score" => 0, "Total" => 0, "Max" => 0}

  endgame = false
  turn = "player1"

  def populate_dict db
    f = File.open(db)
    dict = []
    f.each_line {|line| dict.push line.chomp.upcase.split""}
    return dict
  end


  def update_score word, player, points
    player["Score"] = 0
    word.each do |letter|
      player["Score"] += points[letter]
    end
    puts "#{player}'s score is #{player["Score"]}"
    return player["Score"]
  end

  def update_total score, player
    player["Total"] += score
    puts "#{player}'s total is #{player["Total"]}"
    return player["Total"]
  end

  def update_max score, player
    if score > player["Max"]
      player["Max"] = score
      puts "#{player}'s max is #{player["Max"]}"
      return player["Max"]
    end
  end

  def writeto_scorecard scorecard
    open(scorecard, 'w') { |f|
      f << "Player1's total is #{player1["Total"]}\n"
      f << "Player1's max is #{player1["Max"]}\n"
      f << "Player2's total is #{player2["Total"]}\n"
      f << "Player2's max is #{player2["Max"]}\n"
    }
  end

  dict = populate_dict "wordsEn.txt"

  until endgame == true

    print "Enter word: \n"

    word = gets.chomp.upcase.split ""

    print word.join
    puts
    if word.join == "GAME OVER"
      endgame = true
    elsif dict.include? word && (turn == "player1")
      score = update_score word,player1,points
      total1 = update_total score, player1
      max1 = update_max score, player1
      turn = "player2"
    elsif dict.include? word && (turn == "player2")
      score = update_score word,player2,points
      total1 = update_total score, player2
      max1 = update_max score, player2
      turn = "player1"
    else
      print "Invalid entry. "
    end
  end

  writeto_scorecard "scorecard.txt"
