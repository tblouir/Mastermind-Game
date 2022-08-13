class Game
  attr_reader :secret_colors, :correct_spots, :board
  def initialize
    @correct_spots = Array.new(4)
    @secret_colors = []
    @board = Array.new(4, 'Empty ')
  end

  private def display_board
    puts ""
    @board.each do |element|
      print element
      print "  "
    end
    puts ""
  end
  
  private def choose_colors
    colors = %w[black white red green blue yellow]
    4.times do
      color_index = rand(colors.length).floor
      @secret_colors << colors[color_index]
    end  
  end

  private def guess_color
    print "Choose your colors: "
    answer = gets.chomp.downcase.split
    answer.each_index do |index|
      if answer[index] == @secret_colors[index]
        @correct_spots[index] = answer[index]
        @board[index] = answer[index]
      elsif @secret_colors.include?(answer[index])
        puts "#{answer[index]} is a color, but not in the right spot."
      end
    end
    display_board
  end

  private def restart
    @secret_colors.clear
    @correct_spots = Array.new(4)
    @board = Array.new(4, ' Empty ')
    puts "Want to play again? Y or N"
    answer = gets.chomp.downcase
    if answer == "y"
      puts ""
      play_game
    end
  end

  def play_game
    turns = 1
    display_board
    choose_colors
    # print "Secret colors: #{@secret_colors}"

    until turns > 12
      if @correct_spots.include?(nil)
        puts "\nTurn Number: #{turns}"
        puts "Last Guess!" if turns == 12
        guess_color
      else
        print "\n###\n###\n###\n"
        puts "You guessed all the colors!"
        print "###\n###\n###\n\n"
        restart
        break
      end
      turns += 1
    end

    if turns > 12 && @correct_spots.include?(nil)
      print "\n###\n###\n###\n"
      puts "You failed to guess the colors in 12 turns."
      print "###\n###\n###\n\n"
      restart
    end
  end

end

game = Game.new
game.play_game