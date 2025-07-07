# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

class Player
  attr_reader :name, :total_score, :in_game

  def initialize(name)
    @name = name
    @total_score = 0
    @in_game = false
  end

  def update_score(score)
    if !@in_game && score >= 300
      @in_game = true
    end
    @total_score += score if @in_game
  end
end

class Game
  attr_reader :players, :dice_set

  def initialize(player_names)
    @players = player_names.map { |name| Player.new(name) }
    @dice_set = DiceSet.new
    @game_over = false
  end

  def score(dice)
    counts = Hash.new(0)
    dice.each { |num| counts[num] += 1 }

    score = 0
    counts.each do |num, count|
      if count >= 3
        if num == 1
          score += 1000
        else
          score += num * 100
        end
        count -= 3
      end

      if num == 1
        score += count * 100
      elsif num == 5
        score += count * 50
      end
    end
    score
  end

  def turn(player)
    turn_score = 0
    dice_left = 5
    puts "#{player.name}'s turn"

    while true
      @dice_set.roll(dice_left)
      roll_score = score(@dice_set.values)
      if roll_score == 0
        puts "Rolled: #{@dice_set.values} -> No score. Turn over."
        turn_score = 0
        break
      else
        turn_score += roll_score
        puts "Rolled: #{@dice_set.values} -> Score: #{roll_score}. Total Turn Score: #{turn_score}"
        dice_left = dice_left - (@dice_set.values.size - dice_left)
        dice_left = 5 if dice_left <= 0

        puts "Roll again? (y/n)"
        break if gets.chomp.downcase != 'y'
      end
    end

    player.update_score(turn_score) if turn_score >= 300 || player.in_game
    puts "#{player.name} ends turn with score: #{turn_score}, Total Score: #{player.total_score}"
  end

  def play
    until @game_over
      @players.each do |player|
        turn(player)
        if player.total_score >= 3000
          @game_over = true
          puts "#{player.name} has reached 3000 points! Final round begins."
          break
        end
      end
    end
    final_round
  end

  def final_round
    @players.each do |player|
      next if player.total_score >= 3000
      turn(player)
    end
    declare_winner
  end

  def declare_winner
    winner = @players.max_by(&:total_score)
    puts "The winner is #{winner.name} with #{winner.total_score} points!"
  end
end